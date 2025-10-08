// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:aeronavigatsiya/core/config/network_constants.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/library/chapter_page.dart';
import 'package:aeronavigatsiya/presentation/teachers/screens/teacher_home/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  String? name;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data();
      setState(() {
        name = data?['name'] ?? user.displayName ?? 'Ustoz';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    List<String> titles = [
      "Havodagi harakatni boshqarish",
      "Radioelektron qurilmalar va tizimlar (Aviatsiya)",
      "Amaliy kosmik texnologiyalar",
    ];

    List<String> images = [
      "assets/images/HHB.png",
      "assets/images/Radio.png",
      "assets/images/AKT.png",
    ];

    List<String> paths = [
      NetworkConstants.library,
      NetworkConstants.aktLibrary,
      NetworkConstants.radioLibrary,
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: const MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Glassmorphism SliverAppBar
            SliverAppBar(
              pinned: true,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: FlexibleSpaceBar(
                    title: Text(
                      _buildGreeting(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                    background: Container(
                      color: Colors.white.withOpacity(0.15),
                    ),
                  ),
                ),
              ),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black87,
                    size: 28.sp,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),

            // Body content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ChaptersPage(path: paths[index]),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.05,
                                            ),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16.r),
                                            ),
                                            child: Image.asset(
                                              images[index],
                                              height: height * .2,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              frameBuilder:
                                                  (
                                                    context,
                                                    child,
                                                    frame,
                                                    wasSynchronouslyLoaded,
                                                  ) {
                                                    if (wasSynchronouslyLoaded) {
                                                      return child;
                                                    }
                                                    return frame != null
                                                        ? child
                                                        : Shimmer.fromColors(
                                                            baseColor: Colors
                                                                .grey
                                                                .shade200,
                                                            highlightColor:
                                                                Colors
                                                                    .grey
                                                                    .shade100,
                                                            period:
                                                                const Duration(
                                                                  milliseconds:
                                                                      1200,
                                                                ),
                                                            child: Container(
                                                              height:
                                                                  height * .2,
                                                              width: double
                                                                  .infinity,
                                                              color: Colors
                                                                  .grey
                                                                  .shade200,
                                                            ),
                                                          );
                                                  },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.w),
                                            child: Center(
                                              child: Text(
                                                titles[index],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Salomlashuv matni
  String _buildGreeting() {
    if (name == null) return "Yuklanmoqda...";
    return "Salom👋, ustoz $name";
  }
}
