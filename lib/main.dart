import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/repo_selection_page.dart';
import 'screens/main_page.dart';
import 'screens/milestones_screen.dart';
import 'screens/recent_commits_screen.dart';
import 'screens/my_tils_screen.dart';
import 'screens/commit_detail_screen.dart';
import 'screens/issue_edit_screen.dart';
import 'screens/issue_add_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitCat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
