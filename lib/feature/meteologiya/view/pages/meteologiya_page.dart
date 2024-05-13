import 'package:aviatoruz/feature/meteologiya/view/pages/add_mavzu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeteologiyaPage extends StatelessWidget {
  const MeteologiyaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          "Meteologiya",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 9, 107, 187),
            letterSpacing: 4,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisExtent: 10,
        ),
        itemBuilder: (context, index) {
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoModalPopupRoute(
              builder: (context) => const ADDMavzu(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
