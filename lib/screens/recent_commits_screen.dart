import 'package:flutter/material.dart';
import '../models/commit.dart';
import '../widgets/commit_card.dart';

class RecentCommitsScreen extends StatelessWidget {
  final List<Commit> commits = [
    Commit(name: 'Commit 1', username: 'User1', date: 'Date1', issue: 'Issue1'),
    Commit(name: 'Commit 2', username: 'User2', date: 'Date2', issue: 'Issue2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/logo.png', height: 40), // Adjust the logo asset
            SizedBox(width: 10),
            Text('GitCat', style: TextStyle(color: Colors.black, fontSize: 24)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.circle, color: Color(0xFF8E5C9A)),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical, // Change scroll direction to vertical
        controller: PageController(viewportFraction: 0.8),
        itemCount: commits.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CommitCard(commit: commits[index]),
          );
        },
      ),
    );
  }
}
