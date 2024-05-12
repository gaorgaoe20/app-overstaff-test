import 'package:flutter/material.dart';

class DefaultLinkButton extends StatefulWidget {

  final String? textLabel;
  final Function? onPress;
  final Color? color;
  final double? size;

  DefaultLinkButton({ super.key, this.textLabel, this.onPress, this.color, this.size});

  @override
  State<DefaultLinkButton> createState() => _DefaultLinkButtonState();
}

class _DefaultLinkButtonState extends State<DefaultLinkButton> {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context); 

    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        backgroundColor: widget.color
      ),
      onPressed: widget.onPress as void Function()?, 
      child: Text(
        widget.textLabel as String,
        style: TextStyle(
          color: widget.color ?? theme.colorScheme.onSurface,
          fontSize: widget.size ?? 20,
        ),
      )
    );
  }
}