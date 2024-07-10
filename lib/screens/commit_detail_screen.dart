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
    // tilController.text = widget.commit.tilContent ?? 'TIL content goes here';
  }

  Future<void> fetchTil() async {
    final response = await http.get(
      Uri.parse('http://34.47.114.222:3000/gitcat/fetch/single-til?user_github_id=${widget.userGithubId}&commit_id=${widget.commit.commitId}&gitcat_secret=${widget.storedSecret}'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        til = TIL.fromJson(data['til']);
        tilController.text = til?.tilContent ?? 'TIL content goes here';
      });
      print('Success to load til');
    } else {
      // Handle the error appropriately here
      print('Failed to load til');
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
        actions: [
          IconButton(
            icon: Icon(Icons.circle, color: Color(0xFF8E5C9A)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
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
      ),
    );
  }
}
