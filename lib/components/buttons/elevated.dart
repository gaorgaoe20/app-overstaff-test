import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatefulWidget {
  DefaultElevatedButton({
    Key? key,
    this.textLabel,
    this.onPress,
  });

  final String? textLabel;
  final Function? onPress;

  @override
  State<DefaultElevatedButton> createState() => _DefaultElevatedButtonState();
}

class _DefaultElevatedButtonState extends State<DefaultElevatedButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        backgroundColor: theme.colorScheme.primary
      ),
      onPressed: widget.onPress as void Function()?, 
      child: Text(
        widget.textLabel as String,
        style: TextStyle(
          color: theme.colorScheme.onPrimary
        ),
      )
    );
  }
}