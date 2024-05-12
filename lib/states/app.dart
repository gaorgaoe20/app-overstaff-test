
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String apiToken = "";
  bool ready = false;

  void started() {
    ready = true;
    notifyListeners();
  }

}