

import 'package:app_products_guillermo/components/buttons/link.dart';
import 'package:app_products_guillermo/components/login_form.dart';
import 'package:app_products_guillermo/components/shared/logo.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

      return Scaffold(
        body: Container(
            color: theme.colorScheme.primaryContainer,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageLogo(),
                      LoginForm(),
                      DefaultLinkButton(
                        onPress: () {
                          Navigator.pushNamed(context, '/register');
                        }, 
                        textLabel: "Register",
                      )
                    ]
                ),
              ),
            )
          ),
      );
    
  }
}