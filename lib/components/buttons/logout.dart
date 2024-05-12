import 'package:app_products_guillermo/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatefulWidget {
  LogoutButton({
    super.key,
    this.color
  });

  final Color? color;
  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  void logout() async {
    ApiFetch().post({}, 'logout');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');

    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    Color iconColor = widget.color ?? theme.colorScheme.onPrimary;

    return IconButton(
      onPressed: logout, 
      icon: Icon(
        Icons.logout,
        color: iconColor,
      )
    );
  }
}
