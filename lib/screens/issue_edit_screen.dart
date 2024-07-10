import 'package:flutter/material.dart';
import '../models/issue.dart';

class IssueEditScreen extends StatelessWidget {
  final Issue issue;

  IssueEditScreen({required this.issue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Issue')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // controller: TextEditingController(text: issue.name),
              controller: TextEditingController(text: 'dummy'),
            ),
            // Add other fields here
            ElevatedButton(
              onPressed: () {
                // Update issue logic
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                // Close issue logic
              },
              child: Text('Close Issue', style: TextStyle(color: Colors.red)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
