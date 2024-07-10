import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/label.dart';
import '../models/milestone.dart';
import '../models/issue.dart';
import 'issue_edit_screen.dart';
import 'package:http/http.dart' as http; // For making HTTP requests

class MilestonesScreen extends StatefulWidget {
  final String userGithubId;
  final String ownerGithubId;
  final String repoGithubId;
  final String storedSecret = dotenv.get('GITCAT_SECRET');

  MilestonesScreen({required this.userGithubId, required this.ownerGithubId, required this.repoGithubId});

  @override
  _MilestonesScreenState createState() => _MilestonesScreenState();
}

class _MilestonesScreenState extends State<MilestonesScreen> {
  List<Milestone> milestones = [];
  List<Issue> issues = [];
  List<Label> labels = [];
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    fetchMilestonesIssuesLabels();
  }

  Future<void> fetchMilestonesIssuesLabels() async {
    final response = await http.get(
      Uri.parse(
        'http://34.47.114.222:3000/gitcat/retrieve/mlstns-issues-labels?user_github_id=${widget.userGithubId}&owner_github_id=${widget.ownerGithubId}&repo_github_id=${widget.repoGithubId}&gitcat_secret=${widget.storedSecret}',
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        milestones = parseMilestones(data['milestones']);
        issues = parseIssues(data['issues']);
        labels = parseLabels(data['labels']);
      });
      print('Success to load milestones, issues, and labels');
    } else {
      // Handle the error appropriately here
      print('Failed to load milestones, issues, and labels');
    }
  }

  List<Milestone> parseMilestones(dynamic data) {
    final parsed = data as List;
    return parsed.map<Milestone>((json) => Milestone.fromJson(json)).toList();
  }

  List<Issue> parseIssues(dynamic data) {
    final parsed = data as List;
    return parsed.map<Issue>((json) => Issue.fromJson(json)).toList();
  }

  List<Label> parseLabels(dynamic data) {
    final parsed = data as List;
    return parsed.map<Label>((json) => Label.fromJson(json)).toList();
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
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: milestones.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                color: Color(0xFF8E5C9A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  key: Key(index.toString()),
                  initiallyExpanded: index == _expandedIndex,
                  title: Text(milestones[index].mlstnTitle, style: TextStyle(color: Colors.white, fontSize: 20)),
                  children: [
                    Column(
                      children: [
                        for (var issue in issues.where((i) => i.mlstnId == milestones[index].mlstnId))
                          ListTile(
                            title: Text(issue.issueTitle, style: TextStyle(color: Colors.white)),
                            onTap: () {
                              // Navigate to Issue Edit Screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => IssueEditScreen(issue: issue)),
                              );
                            },
                          ),
                        ListTile(
                          title: Text('Add new issue', style: TextStyle(color: Colors.white)),
                          tileColor: Color(0xFFCDC3D0),
                          onTap: () {
                            // Add new issue logic here
                          },
                        ),
                      ],
                    ),
                  ],
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _expandedIndex = expanded ? index : null;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF8E5C9A),
        onPressed: () {
          // Add new milestone logic here
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
