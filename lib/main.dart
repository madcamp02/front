import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitCat',
      theme: ThemeData(
        primarySwatch: Colors.blue, fontFamily: 'Pretendard'
      ),
      home: LoginPage(),
    );
  }
}
