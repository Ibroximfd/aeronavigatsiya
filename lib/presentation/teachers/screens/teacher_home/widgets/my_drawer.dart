// ignore_for_file: deprecated_member_use

import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_event.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/auth/auth_state.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/auth/auth_gate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut || state is AuthDeleted) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoDialogRoute(
              builder: (context) => const AuthGate(),
              context: context,
            ),
            (route) => false,
          );
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(-20 * (1 - value), 0),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.blue.shade600,
                                  Colors.blue.shade900,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                "AERONAVIGATISYA",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                            height: 20,
                          ),

                          // Share tile
                          _buildListTile(
                            context,
                            icon: Icons.share,
                            title: "Ulashish",
                            iconColor: Colors.green.shade600,
                            onTap: () {
                              Share.share(
                                'check out my website https://example.com',
                                subject: 'Look what I made!',
                              );
                            },
                          ),

                          // Delete account tile
                          _buildListTile(
                            context,
                            icon: Icons.delete_forever,
                            title: "Akkountni o‘chirish",
                            iconColor: Colors.orange.shade700,
                            onTap: () => _confirmDelete(context),
                          ),

                          const Spacer(),

                          // Logout tile
                          _buildListTile(
                            context,
                            icon: Icons.exit_to_app,
                            title: "Chiqish",
                            iconColor: Colors.red.shade600,
                            onTap: () => _confirmLogout(context),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Logout confirmation dialog
  Future<void> _confirmLogout(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Chiqish"),
        content: const Text("Haqiqatan ham tizimdan chiqmoqchimisiz?"),
        actions: [
          TextButton(
            child: const Text("Bekor qilish"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Ha, chiqish", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (result == true) {
      context.read<AuthBloc>().add(LogOutEvent());
    }
  }

  /// ✅ Delete account confirmation dialog
  Future<void> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Akkountni o‘chirish"),
        content: const Text(
          "Rostdan ham akkountni o‘chirilsinmi? Bu amalni qaytarib bo‘lmaydi!",
        ),
        actions: [
          TextButton(
            child: Text("Bekor qilish"),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              "Ha, o‘chirilsin",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (result == true) {
      context.read<AuthBloc>().add(DeleteAccountEvent());
    }
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutBack,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(icon, color: iconColor, size: 28),
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              onTap: onTap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
            ),
          ),
        );
      },
    );
  }
}
