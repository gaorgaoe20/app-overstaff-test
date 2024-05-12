import 'package:app_products_guillermo/states/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/index.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Products App',

        // Theme setting
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 15, 141, 62),
            primary: Color.fromARGB(255, 15, 141, 62),
            onPrimary: Colors.white,
            secondary: Color.fromARGB(255, 116, 156, 148),
            onSecondary: Colors.white, 
            error: Color.fromARGB(255, 255, 44, 44),
            onError: Colors.white,
            primaryContainer: Color.fromARGB(255, 244, 248, 249),
            surface: Color.fromARGB(255, 229, 252, 242),
            onSurface: Color.fromARGB(255, 8, 64, 43)
          ),
          useMaterial3: true,
        ),


        

        // Routes Setting
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/dashboard': (context) => DashboardScreen()
        },


        
      ),
    );

    
    
  }
}