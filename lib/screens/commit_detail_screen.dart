import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/commit.dart';
import '../models/til.dart';
import 'package:intl/intl.dart'; // For formatting the date
import 'package:http/http.dart' as http; // For making HTTP requests

class CommitDetailScreen extends StatefulWidget {
  final Commit commit;
  final int userGithubId;
  final String storedSecret = dotenv.get('GITCAT_SECRET');

  CommitDetailScreen({required this.commit, required this.userGithubId});

  @override
  _CommitDetailScreenState createState() => _CommitDetailScreenState();
}

class _CommitDetailScreenState extends State<CommitDetailScreen> {
  TextEditingController tilController = TextEditingController();
  TIL? til;

  @override
  void initState() {
    super.initState();
    fetchTil();
    // tilController.text = widget.commit.tilContent ?? 'TIL content goes here';
  }

  Future<void> fetchTil() async {
    final response = await http.get(
      Uri.parse('http://34.47.114.222:3000/gitcat/fetch/single-til?user_github_id=${widget.userGithubId}&commit_id=${widget.commit.commitId}&gitcat_secret=${widget.storedSecret}'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        // print(data['til']['tilObj']);
        print(data['til']);
        tilController.text = json.decode(data['til'])[0]['til_content'];
      });
      print('Success to load til');
    } else {
      // Handle the error appropriately here
      print('Failed to load til');
    }
  }

  Future<void> saveTil() async {
    final response = await http.patch(
      Uri.parse('http://34.47.114.222:3000/gitcat/patch/til?user_github_id=${widget.userGithubId}&commit_id=${widget.commit.commitId}&gitcat_secret=${widget.storedSecret}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'til_content': tilController.text,
      }),
    );

    if (response.statusCode == 200) {
      print('TIL content saved successfully');
    } else {
      print('Failed to save TIL content');
    }
  }

  @override
  void dispose() {
    tilController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8E5C9A),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Color(0xFF8E5C9A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.commit.commitMsg,
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd – kk:mm').format(widget.commit.commitDate),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Divider(color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Owner: ${widget.commit.ownerGithubId}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Issues:',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: widget.commit.issueIdList.map((issue) {
                          return Chip(
                            label: Text(issue.toString()),
                            backgroundColor: Color(0xFFCDC3D0),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'TIL ID: ${widget.commit.tilId ?? 'None'}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFEBE3EB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: tilController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'TIL content goes here',
                            ),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Comment',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFEBE3EB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            maxLines: 5,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: saveTil,
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFF8E5C9A), // Text color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}