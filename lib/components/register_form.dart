import 'dart:convert';

import 'package:app_products_guillermo/api.dart';
import 'package:app_products_guillermo/components/buttons/elevated.dart';
import 'package:app_products_guillermo/components/cards/default.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _formKey = GlobalKey<FormState>();

  bool _registering = false;

  String? email;
  String? password;
  String? name;

  _showMessage(msg) {

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void register() async {
    setState(() {
      _registering = true;
    });
    
    Object data = {
      'email': email,
      'password': password,
      'name':  name
    };

    var result = await ApiFetch().post(data, 'register');

    var body = json.decode(result.body);
    if(body['api_token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['api_token']));
      Navigator.pushNamed(context, '/dashboard');
    } else {
      _showMessage(body['message']);
    }

    setState(() {
      _registering = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final title_text = theme.textTheme.titleLarge!.copyWith(
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
                    Icons.person_add,
                    size: 30,
                    color: theme.colorScheme.onSurface,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Register",
                    style: title_text,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: _registering,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  prefixIcon: Icon(Icons.person_add),
                  prefixIconColor: theme.colorScheme.primary,
                  labelText: "Name",
                ),
                validator: (nameValue) {
                  if(nameValue == null || nameValue.isEmpty) {
                    return "The name field is required";
                  }
                  name = nameValue;
                  return null;

                },
              ),
              TextFormField(
                readOnly: _registering,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: theme.colorScheme.primary,
                  labelText: "E-mail",
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
                readOnly: _registering,
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: theme.colorScheme.primary,
                  labelText: "Password",
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
                  textLabel: "Sign Up",
                  onPress: _registering ? null : () {
                    if(_formKey.currentState!.validate()) {
                      register();
                    }
                  },
                ) 
              )
            ],
          ),
        ),
      ),
    );
  }
}