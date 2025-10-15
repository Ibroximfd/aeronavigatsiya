// super_teacher_panel.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuperTeacherPanelPage extends StatefulWidget {
  const SuperTeacherPanelPage({super.key});

  @override
  State<SuperTeacherPanelPage> createState() => _SuperTeacherPanelPageState();
}

class _SuperTeacherPanelPageState extends State<SuperTeacherPanelPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Tizimga kirmagansiz. Iltimos avval login qiling.",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.red),
          ),
        ),
      );
    }

    // 1) Avval hozirgi foydalanuvchining role ni olamiz (super_teacher ekanligini tekshirish)
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _firestore.collection('users').doc(currentUser.uid).get(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snap.hasData || !snap.data!.exists) {
          return Scaffold(
            body: Center(
              child: Text(
                "Foydalanuvchi hujjati topilmadi.",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            ),
          );
        }

        final docData = snap.data!.data();
        final role = docData == null ? null : (docData['role'] as String?);

        if (role != 'super_teacher') {
          return Scaffold(
            body: Center(
              child: Text(
                "Sizga bu sahifaga kirish taqiqlangan.",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            ),
          );
        }

        // 2) Agar super_teacher bo'lsa, teacher va teacher_pending lar stream bilan ko'rsatamiz
        return Scaffold(
          appBar: AppBar(
            title: const Text("O'qituvchilar Boshqaruv Paneli"),
            centerTitle: true,
            elevation: 4,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _firestore
                .collection('users')
                .where('role', whereIn: ['teacher', 'teacher_pending'])
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "Hozircha hech qanday o‘qituvchi topilmadi.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final userDoc = docs[index];
                  final data = userDoc.data();
                  final name = data['name'] ?? 'No name';
                  final email = data['email'] ?? 'No email';
                  final role = data['role'] ?? '';
                  final uid = userDoc.id;

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: () {
                        // Bosilganda to'liq profili ko'rsatiladi
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TeacherDetailPage(uid: uid, data: data),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: role == 'teacher_pending'
                            ? Colors.orange
                            : Colors.blue,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "$email • ${role == 'teacher_pending' ? 'Kutilmoqda' : 'Tasdiqlangan'}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (role == 'teacher_pending')
                            ElevatedButton.icon(
                              onPressed: () => _confirmApprove(uid),
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              label: const Text("Tasdiqlash"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          if (role == 'teacher')
                            ElevatedButton.icon(
                              onPressed: () => _confirmRemove(uid),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              label: const Text("O‘chirish"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _confirmApprove(String uid) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tasdiqlash"),
        content: const Text(
          "Ushbu foydalanuvchini o‘qituvchi sifatida tasdiqlaysizmi?",
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Bekor qilish"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Tasdiqlash"),
          ),
        ],
      ),
    );

    if (ok == true) return _approveTeacher(uid);
  }

  Future<void> _confirmRemove(String uid) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("O‘chirish"),
        content: const Text(
          "Ushbu foydalanuvchini o‘qituvchilikdan olib tashlamoqchimisiz?",
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Bekor qilish"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Olib tashlash"),
          ),
        ],
      ),
    );

    if (ok == true) return _removeTeacher(uid);
  }

  Future<void> _approveTeacher(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({'role': 'teacher'});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("O‘qituvchi tasdiqlandi ✅"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xatolik: $e"), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _removeTeacher(String uid) async {
    try {
      // teacher ni olib tashlash -> role ni student ga o'zgartirish (siz xohlasangiz boshqa role ham qo'ying)
      await _firestore.collection('users').doc(uid).update({'role': 'student'});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("O‘qituvchi olib tashlandi ❌"),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Xatolik: $e"), backgroundColor: Colors.red),
      );
    }
  }
}

class TeacherDetailPage extends StatelessWidget {
  final String uid;
  final Map<String, dynamic> data;

  const TeacherDetailPage({super.key, required this.uid, required this.data});

  String _formatTimestamp(dynamic ts) {
    try {
      if (ts == null) return '-';
      if (ts is Timestamp) {
        final dt = ts.toDate();
        return DateFormat.yMMMMd(
          'uz',
        ).add_jm().format(dt); // Uzbek tilida formatlash
      }
      if (ts is DateTime) {
        return DateFormat.yMMMMd('uz').add_jm().format(ts);
      }
      return ts.toString();
    } catch (_) {
      return ts.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = data['name'] ?? '-';
    final email = data['email'] ?? '-';
    final role = data['role'] ?? '-';
    final password =
        data['password'] ?? '-'; // takror: plaintext password xavfli!
    final createdAt = _formatTimestamp(data['createdAt']);

    return Scaffold(
      appBar: AppBar(title: Text(name), centerTitle: true, elevation: 4),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(context, "UID", uid),
                const SizedBox(height: 12),
                _buildDetailRow(context, "Ism", name),
                const SizedBox(height: 12),
                _buildDetailRow(context, "Email", email),
                const SizedBox(height: 12),
                _buildDetailRow(
                  context,
                  "Role",
                  role == 'teacher_pending' ? 'Kutilmoqda' : 'Tasdiqlangan',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(context, "Parol (Firestore)", password),
                const SizedBox(height: 12),
                _buildDetailRow(context, "Yaratilgan vaqti", createdAt),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Kerak bo'lsa bu erda qo'shimcha amallar (masalan role o'zgartirish) qo'yish mumkin
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Tahrirlash (keyinchalik qo'shing)"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
