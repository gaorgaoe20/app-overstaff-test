import 'package:flutter/material.dart';

class ImageLogo extends StatelessWidget {
  const ImageLogo({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Color.fromARGB(0, 255, 255, 255),
      elevation: 0,
      child: Image(
          width: 150,
          height: 150,
          image: AssetImage('assets/images/logo.png'),
        )
      );
  }
}