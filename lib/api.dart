
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiFetch {
  final _baseUrl = dotenv.get('API_URL');

  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tokenApi = localStorage.getString('token');
    try {
      token = json.decode(tokenApi ?? "");
    } catch(e) {
      print('Error: ${e.toString()}');
    }
    
  }

  post(data, path) async  {
    await _getToken();
    return await http.post(
      Uri.parse("${_baseUrl}/${path}"),
      body: json.encode(data),
      headers: _getHeaders()
    );
  }


  get(params, path) async {
    await _getToken();
    return await http.get(
      Uri.parse("${_baseUrl}/${path}"),
      headers: _getHeaders()
    );
  }

  delete(data, path) async  {
    await _getToken();
    return await http.delete(
      Uri.parse("${_baseUrl}/${path}"),
      body: json.encode(data),
      headers: _getHeaders()
    );
  }

  _getHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };
}