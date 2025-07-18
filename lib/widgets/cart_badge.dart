import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  final Widget child;
  final int value;

  CartBadge({required this.child, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        if (value > 0)
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$value',
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
