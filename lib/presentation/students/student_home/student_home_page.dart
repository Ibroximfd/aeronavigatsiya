// ignore_for_file: deprecated_member_use

import 'package:aviatoruz/presentation/students/student_home/widgets/student_drawer.dart';
import 'package:aviatoruz/presentation/students/student_library/student_chapter_page.dart';
import 'package:aviatoruz/presentation/teachers/screens/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Custom SliverAppBar
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    "AERONAVIGATSIYA",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black38,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade500,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
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
                        blurRadius: 4,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    icon: Icon(Icons.settings))
              ],
            ),
            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                          children: [
                            SizedBox(height: 30.h),
                            // Metrologiya Card
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => StudentChaptersPage(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: Colors.blue.shade200,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.blue.shade100.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.asset(
                                        "assets/images/HHB.png",
                                        height: height * .2,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) {
                                          if (wasSynchronouslyLoaded)
                                            return child;
                                          return frame != null
                                              ? child
                                              : Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade200,
                                                  highlightColor:
                                                      Colors.blue.shade100,
                                                  period: const Duration(
                                                      milliseconds: 1200),
                                                  child: Container(
                                                    height: height * .2,
                                                    width: double.infinity,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "Havodagi harakatni boshqarish",
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            // Test Card
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: Colors.blue.shade200,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.blue.shade100.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.asset(
                                        "assets/images/AKT.png",
                                        height: height * .16,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) {
                                          if (wasSynchronouslyLoaded)
                                            return child;
                                          return frame != null
                                              ? child
                                              : Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade200,
                                                  highlightColor:
                                                      Colors.blue.shade100,
                                                  period: const Duration(
                                                      milliseconds: 1200),
                                                  child: Container(
                                                    height: height * .16,
                                                    width: double.infinity,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "Amaliy kosmik texnologiyalar",
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            // Adjusted for no FAB
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: Colors.blue.shade200,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.blue.shade100.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.asset(
                                        "assets/images/Radio.png",
                                        height: height * .16,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        frameBuilder: (context, child, frame,
                                            wasSynchronouslyLoaded) {
                                          if (wasSynchronouslyLoaded)
                                            return child;
                                          return frame != null
                                              ? child
                                              : Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade200,
                                                  highlightColor:
                                                      Colors.blue.shade100,
                                                  period: const Duration(
                                                      milliseconds: 1200),
                                                  child: Container(
                                                    height: height * .16,
                                                    width: double.infinity,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "Radioelektron qurilmalar va tizimlar (Aviatsiya)",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
      drawer: const StudentDrawer(),
    );
  }
}
