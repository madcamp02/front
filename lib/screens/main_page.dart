import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'milestones_screen.dart';
import 'recent_commits_screen.dart';
import 'my_tils_screen.dart';

class MainPage extends StatelessWidget {
  final String userGithubId;
  final String repoGithubId;
  final String ownerGithubId;
  final String gitcatSecret;

  MainPage({
    required this.userGithubId,
    required this.repoGithubId,
    required this.ownerGithubId,
    required this.gitcatSecret,
  }) {
    print('================================');
    print('main page input');
    print('userGithubId: $userGithubId');
    print('repoGithubId: $repoGithubId');
    print('ownerGithubId: $ownerGithubId');
    print('gitcatSecret: $gitcatSecret');
    print('================================');
  }

  Future<void> sendRepoDetails() async {
    final response = await http.post(
      Uri.parse('http://34.64.230.8:3000/retrieve/commits'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_github_id': userGithubId,
        'repo_github_id': repoGithubId,
        'owner_github_id': ownerGithubId,
        'gitcat_secret': gitcatSecret,
      }),
    );

    if (response.statusCode == 200) {
      print('Repository details sent successfully');
    } else {
      print('Failed to send repository details');
      print('Response body: ${response.body}');
    }
  }

  Future<void> sendTilDetails() async {
    final response = await http.post(
      Uri.parse('http://34.64.230.8:3000/fetch/tils'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_github_id': userGithubId,
        'owner_github_id': ownerGithubId,
        'gitcat_secret': gitcatSecret,
      }),
    );

    if (response.statusCode == 200) {
      print('TIL details sent successfully');
    } else {
      print('Failed to send TIL details');
      print('Response body: ${response.body}');
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
            Image.asset('assets/logo.png', height: 40),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Review your Day',
              style: TextStyle(color: Color(0xFF8E5C9A), fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/cat1.png', height: 60),
                Image.asset('assets/cat2.png', height: 60),
                Image.asset('assets/cat3.png', height: 60),
                Image.asset('assets/cat4.png', height: 60),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 120,
                    child: Card(
                      color: Color(0xFF8E5C9A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.event_note, color: Colors.white, size: 40),
                          title: Text('Milestones', style: TextStyle(color: Colors.white, fontSize: 24)),
                          onTap: () async {
                            // await sendRepoDetails();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MilestonesScreen(userGithubId: userGithubId, ownerGithubId: ownerGithubId, repoGithubId: repoGithubId)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: Card(
                      color: Color(0xFF8E5C9A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.access_time, color: Colors.white, size: 40),
                          title: Text('Recent Commits', style: TextStyle(color: Colors.white, fontSize: 24)),
                          onTap: () async {
                            await sendRepoDetails();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RecentCommitsScreen(userGithubId: userGithubId, repoGithubId: repoGithubId)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: Card(
                      color: Color(0xFF8E5C9A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.event_note, color: Colors.white, size: 40),
                          title: Text('My TILs', style: TextStyle(color: Colors.white, fontSize: 24)),
                          onTap: () async {
                            // await sendTilDetails();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyTILsScreen(userGithubId: userGithubId, ownerGithubId: ownerGithubId)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
