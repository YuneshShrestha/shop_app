import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  Widget? child;
  Color? color;
  String? value;
  Badge({required this.child, this.color, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child!,
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: color ?? Theme.of(context).colorScheme.secondary),
            constraints: const BoxConstraints(minWidth: 16, maxHeight: 16),
            child: Text(
              value!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10.0),
            ),
          ),
        )
      ],
    );
  }
}
