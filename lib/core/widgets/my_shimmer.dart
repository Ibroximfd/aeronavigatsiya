import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  const MyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.black.withOpacity(0.04),
        highlightColor: Colors.black.withOpacity(0.1),
        child: Column(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
                color: Colors.black.withOpacity(0.04),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
                color: Colors.black.withOpacity(0.04),
              ),
            )
          ],
        ),
      ),
    );
  }
}
