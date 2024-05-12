

import 'package:app_products_guillermo/components/buttons/link.dart';
import 'package:app_products_guillermo/components/register_form.dart';
import 'package:app_products_guillermo/components/shared/logo.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    super.key,
    // required this.changeScreen
  });

  // final Function changeScreen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
      
    return Scaffold(
      body: Container(
        color: theme.colorScheme.primaryContainer,
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageLogo(),
                  RegisterForm(),
                  DefaultLinkButton(
                    onPress: () {
                      Navigator.pushNamed(context, '/login');
                    }, 
                    textLabel: "Login",
                  )
                ]
            ),
          ),
        )
      ),
    );
  }
}



