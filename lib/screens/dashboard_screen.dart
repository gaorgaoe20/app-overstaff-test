import 'package:app_products_guillermo/components/buttons/logout.dart';
import 'package:app_products_guillermo/sections/dashboard/index.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  static List<Widget> _sectionOptions = <Widget>[
    DashboardHomeSection(),
    DashboardCartSection()
  ];


  int _sectionIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      _sectionIndex = index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    // Styles Settings
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          LogoutButton(
            color: theme.colorScheme.onPrimary,
          )
        ],
        elevation: 10,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          "Product App",
          style: TextStyle(
            color: theme.colorScheme.onPrimary
          ),
        ),
        automaticallyImplyLeading: false
      ),

      body: _sectionOptions.elementAt(_sectionIndex),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.colorScheme.surface,
        items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart"
            )
        ],
        currentIndex: _sectionIndex,
        selectedItemColor: theme.colorScheme.onSurface,
        onTap: _changeScreen,

      ),
    );
  }
}