import 'dart:ui';
import 'package:aeronavigatsiya/presentation/students/blocs/bloc/student_main_bloc.dart';
import 'package:aeronavigatsiya/presentation/students/blocs/bloc/student_main_event.dart';
import 'package:aeronavigatsiya/presentation/students/blocs/bloc/student_main_state.dart';
import 'package:aeronavigatsiya/presentation/students/student_home/student_home_page.dart';
import 'package:aeronavigatsiya/presentation/students/student_videos_page/student_videos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentMainPage extends StatelessWidget {
  const StudentMainPage({super.key});

  final List<Widget> _pages = const [
    StudentHomePage(),
    StudentVideosPage(),
    Center(child: Text('Tez orada ...')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentMainBloc, StudentMainState>(
      builder: (context, state) {
        return Scaffold(
          body: _pages[state.currentIndex],
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 120),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 0.5,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    BlocProvider.of<StudentMainBloc>(
                      context,
                    ).add(ChangePageEvent(index));
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Bosh sahifa',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.video_library),
                      label: 'Videolar',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat),
                      label: 'Xabarlar',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
