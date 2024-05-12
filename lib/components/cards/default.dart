
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({
    super.key,
    this.color,
    this.elevation,
    this.borderRadius,
    this.child,
  });

  final Color? color;
  final double? elevation;
  final double? borderRadius;
  final Widget? child;

  @override 
  Widget build(BuildContext context) {

    final double radius = borderRadius ?? 0;

    return Card(
      color: color,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius))
      ),
      child: child
    );
  }
}