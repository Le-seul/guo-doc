
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {

  const MyCard({
    Key key,
    @required this.child,
    this.color: Colors.white,
    this.borderRadius: 8.0,
    this.shadowColor: const Color(0xFFDDDDDD)
  }): super(key: key);

  final double borderRadius;
  final Widget child;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(color: shadowColor, offset: Offset(0.0, 2.0), blurRadius: 5.0, spreadRadius: 1.0),
          ]
      ),
      child: child,
    );
  }
}
