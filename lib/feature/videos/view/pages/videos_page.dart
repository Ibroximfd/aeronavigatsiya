import 'package:flutter/material.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        shadowColor: const Color(0xFF000000),
        elevation: 2,
        surfaceTintColor: const Color(0xFFEEEEEE),
        centerTitle: true,
        title: const Text(
          "Videolar",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 9, 107, 187),
            letterSpacing: 4,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "Videolar mavjud emas",
        ),
      ),
    );
  }
}
