import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringProduct extends StatelessWidget {
  const ShimmeringProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: (Colors.grey[300])!,
      highlightColor: (Colors.grey[100])!,
      enabled: true,
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0),
          itemCount: 10,
          itemBuilder: (BuildContext context, int i) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ));
          }),
    );
  }
}
