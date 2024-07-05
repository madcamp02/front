import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with GitHub'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello user'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loginWithGitHub(context),
              child: Text('Login with GitHub'),
            ),
          ],
        ),
      ),
    );
  }

  void _loginWithGitHub(BuildContext context) async {
    final result = await FlutterWebAuth.authenticate(
      url: "https://github.com/login/oauth/authorize?client_id=$githubClientId&scope=read:user,user:email",
      callbackUrlScheme: "myapp",
    );
    final code = Uri.parse(result).queryParameters['code'];
    if (code != null) {
      final token = await _fetchAccessToken(code);
      if (token != null) {
        // Navigate to home screen on successful login
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Future<String?> _fetchAccessToken(String code) async {
    final response = await http.post(
      Uri.parse('https://github.com/login/oauth/access_token'),
      headers: {'Accept': 'application/json'},
      body: {
        'client_id': githubClientId,
        'client_secret': githubClientSecret,
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return body['access_token'];
    }
    return null;
  }
}
