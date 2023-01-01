import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringOrder extends StatelessWidget {
  const ShimmeringOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Shimmer.fromColors(
        baseColor: (Colors.grey[300])!,
        highlightColor: (Colors.grey[100])!,
        enabled: true,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          height: 10.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: 160.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        Container(
                          height: 14.0,
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 10.0,
                  ),
                ],
              )),
          itemCount: 6,
        ),
      ),
    );
  }
}
