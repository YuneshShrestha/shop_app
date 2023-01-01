import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringUser extends StatelessWidget {
  const ShimmeringUser({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 10.0,
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
