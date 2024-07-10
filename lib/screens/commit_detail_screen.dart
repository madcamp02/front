import 'package:flutter/material.dart';
import '../models/commit.dart';
import 'package:intl/intl.dart'; // For formatting the date

class CommitDetailScreen extends StatelessWidget {
  final Commit commit;

  CommitDetailScreen({required this.commit});

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
                  commit.commitMsg,
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('yyyy-MM-dd – kk:mm').format(commit.commitDate),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 8),
                Divider(color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Owner: ${commit.ownerGithubId}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'Issues:',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Wrap(
                  spacing: 8.0,
                  children: commit.issueIdList.map((issue) {
                    return Chip(
                      label: Text(issue.toString()),
                      backgroundColor: Color(0xFFCDC3D0),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text(
                  'TIL ID: ${commit.tilId ?? 'None'}',
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
                  child: Center(
                    child: Text(
                      'TIL content goes here', // This should be replaced with actual TIL content if available
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
