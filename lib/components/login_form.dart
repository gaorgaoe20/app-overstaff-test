import 'dart:convert';

import 'package:app_products_guillermo/api.dart';
import 'package:app_products_guillermo/components/buttons/elevated.dart';
import 'package:app_products_guillermo/components/cards/default.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  bool _isLoggin = false;
  
  String? email;
  String? password;

  _showMessage(msg) {

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void login() async {

    setState(() {
      _isLoggin = true;
    });
  
    Object data = {
      'email': email,
      'password': password
    };

    var result = await ApiFetch().post(data, 'login');

    var body = json.decode(result.body);
    if(body['api_token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['api_token']));
      Navigator.pushNamed(context, '/dashboard');
    } else {
      _showMessage(body['message']);
    }

    setState(() {
      _isLoggin = false;
    });  
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleText = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.bold,
      fontSize: 30
    );


    return DefaultCard(
      color: theme.colorScheme.surface,
      elevation: 5,
      borderRadius: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login,
                    size: 30,
                    color: theme.colorScheme.onSurface,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Login",
                    style: titleText,
                  ),
                ],
              ),
              
              SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: _isLoggin,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: theme.colorScheme.primary,
                  labelText: "E-mail",
                  isDense: true,
                ),
                validator: (emailValue) {
                  if(emailValue == null || emailValue.isEmpty) {
                    return "The E-mail field is required";
                  }
                  email = emailValue;
                  return null;

                },
              ),
              TextFormField(
                readOnly: _isLoggin,
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: theme.colorScheme.primary,
                  labelText: "Password",
                  isDense: true
                ),
                validator: (passValue) {
                  if(passValue == null || passValue.isEmpty) {
                    return "The password field is required";
                  }
                  password = passValue;
                  return null;

                },
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: DefaultElevatedButton(
                  onPress: _isLoggin ? null : () {
                    if(_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  textLabel: "Sign In",
                ) 
              )
            ],
          ),
        ),
      ),
    );
  }
}
