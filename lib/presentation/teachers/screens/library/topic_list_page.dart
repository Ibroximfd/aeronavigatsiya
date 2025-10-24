// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:aeronavigatsiya/data/entity/topic_model.dart';
import 'package:aeronavigatsiya/presentation/teachers/bloc/library/library_bloc.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/library/create_topic_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/library/edit_topic_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/library/topic_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TopicListPage extends StatelessWidget {
  final String path;
  final String chapterId;

  const TopicListPage({super.key, required this.path, required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LibraryBloc(),
      child: Scaffold(
        body: _buildBody(context),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildTopicList(),
          const SliverToBoxAdapter(child: SizedBox(height: 34)),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      leading: const BackButton(color: Colors.black87),
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: FlexibleSpaceBar(
            title: Text(
              'Mavzular',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: 0.3,
                shadows: [
                  Shadow(
                    blurRadius: 1.5,
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
            background: Container(color: Colors.white.withOpacity(0.2)),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTopicList() {
    return SliverToBoxAdapter(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(path)
            .doc(chapterId)
            .collection('topics')
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 200.h,
              child: Center(
                child: CircularProgressIndicator(color: Colors.indigo.shade600),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Text(
                  'Xatolik: ${snapshot.error}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Container(
              height: 300.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.shade50.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 48.sp,
                    color: Colors.indigo.shade400,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Hozircha mavzular yo‘q',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Yangi mavzu qo‘shish uchun "+" tugmasini bosing',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final topics = snapshot.data!.docs.map((doc) {
            return TopicModel.fromJson(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            );
          }).toList();

          return Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: topics
                  .asMap()
                  .entries
                  .map(
                    (entry) => _buildTopicItem(context, entry.value, entry.key),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateTopicPage(chapterId: chapterId),
              ),
            ),
            backgroundColor: Colors.indigo.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: const Icon(Icons.add, color: Colors.white, size: 26),
          ),
        );
      },
    );
  }

  Widget _buildTopicItem(BuildContext context, TopicModel topic, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 80)),
      curve: Curves.easeOut,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 15 * (1 - value)),
            child: _TopicCard(topic: topic, chapterId: chapterId, path: path),
          ),
        );
      },
    );
  }
}

class _TopicCard extends StatelessWidget {
  final TopicModel topic;
  final String chapterId;
  final String path;

  const _TopicCard({
    required this.topic,
    required this.chapterId,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade50.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TopicDetailPage(topic: topic)),
          ),
          onLongPress: () => _showTopicOptions(context, topic, chapterId, path),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_buildTopicImage(), _buildTopicTitle()],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.network(
            topic.imageUrl.isNotEmpty
                ? topic.imageUrl
                : 'https://via.placeholder.com/150',
            width: double.infinity,
            height: 180.h,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.indigo.shade50,
                period: const Duration(milliseconds: 1000),
                child: Container(
                  width: double.infinity,
                  height: 180.h,
                  color: Colors.grey.shade100,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              debugPrint("Topic image error: $error, URL: ${topic.imageUrl}");
              return Container(
                width: double.infinity,
                height: 180.h,
                color: Colors.grey.shade100,
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 40,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopicTitle() {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Text(
        topic.title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }
}

void _showTopicOptions(
  BuildContext context,
  TopicModel topic,
  String chapterId,
  String path,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>
        _TopicOptionsSheet(topic: topic, chapterId: chapterId, path: path),
  );
}

class _TopicOptionsSheet extends StatelessWidget {
  final TopicModel topic;
  final String chapterId;
  final String path;

  const _TopicOptionsSheet({
    required this.topic,
    required this.chapterId,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade50.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildOptions(context),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade300, Colors.indigo.shade500],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Text(
        'Mavzu Opsiyalari',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.96 + (0.04 * value),
            child: Column(
              children: [
                _buildOptionTile(
                  icon: Icons.edit,
                  color: Colors.indigo.shade500,
                  title: 'Tahrirlash',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EditTopicPage(topic: topic, chapterId: chapterId),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Colors.blueGrey),
                _buildOptionTile(
                  icon: Icons.delete,
                  color: Colors.redAccent.shade200,
                  title: 'O‘chirish',
                  onTap: () {
                    Navigator.pop(context);
                    _confirmDelete(context, topic, chapterId, path);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 26.sp),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
    );
  }
}

void _confirmDelete(
  BuildContext context,
  TopicModel topic,
  String chapterId,
  String path,
) {
  showDialog(
    context: context,
    builder: (ctx) => TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: 0.85 + (0.15 * value),
          child: Opacity(
            opacity: value,
            child: AlertDialog(
              backgroundColor: Colors.white.withOpacity(0.98),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: Colors.blueGrey.shade100, width: 1),
              ),
              elevation: 6,
              title: Text(
                'Mavzuni O‘chirish',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              content: Text(
                'Ushbu mavzuni rostdan ham o‘chirmoqchimisiz?',
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
              actions: [
                _buildDialogButton(
                  title: 'Bekor Qilish',
                  colors: [Colors.blueGrey.shade300, Colors.blueGrey.shade500],
                  onPressed: () => Navigator.pop(ctx),
                ),
                _buildDialogButton(
                  title: 'O‘chirish',
                  colors: [
                    Colors.redAccent.shade200,
                    Colors.redAccent.shade400,
                  ],
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.read<LibraryBloc>().add(
                      DeleteTopicEvent(
                        path: path,
                        chapterId: chapterId,
                        topicId: topic.id,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildDialogButton({
  required String title,
  required List<Color> colors,
  required VoidCallback onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
