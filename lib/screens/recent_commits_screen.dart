import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/commit.dart';
import '../widgets/commit_card.dart';

class RecentCommitsScreen extends StatefulWidget {
  final String userGithubId;
  final String repoGithubId;

  RecentCommitsScreen({required this.userGithubId, required this.repoGithubId});

  @override
  _RecentCommitsScreenState createState() => _RecentCommitsScreenState();
}

class _RecentCommitsScreenState extends State<RecentCommitsScreen> {
  List<Commit> commits = [];

  @override
  void initState() {
    super.initState();
    fetchCommits();
  }

  Future<void> fetchCommits() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/gitcat/retrieve/commits'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_github_id': widget.userGithubId,
        'repo_github_id': widget.repoGithubId,
        'gitcat_secret': dotenv.get('GITCAT_SECRET'),
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        commits = (data['commits'] as List).map((commitData) => Commit.fromJson(commitData)).toList();
      });
      print('Commits fetched successfully: ${data['commits']}');
    } else {
      print('Failed to fetch commits');
    }
  }

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
      body: commits.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
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
