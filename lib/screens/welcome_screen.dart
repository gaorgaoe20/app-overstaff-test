
import 'package:app_products_guillermo/components/buttons/elevated.dart';
import 'package:app_products_guillermo/components/shared/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WelcomeScreen extends StatelessWidget {

    const WelcomeScreen({
      super.key
    });

    @override
    Widget build(BuildContext context) {

      final theme = Theme.of(context);
      // Text styles
      final wtStyle = theme.textTheme.displaySmall!.copyWith();


      return Scaffold(
        body: Container(
          color: theme.colorScheme.primaryContainer,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageLogo(),
                  Text(
                    "Welcome to my app",
                    style: wtStyle,
                  ),
                  DefaultElevatedButton(
                    textLabel: 'Start',
                    onPress: () {
                      print("${dotenv.get('API_URL')}");
                      Navigator.pushNamed(context, '/login');
                    }, 
                  )
                ],
              ),
            )
          )
        )
      );
    }
}