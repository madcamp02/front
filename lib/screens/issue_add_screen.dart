import 'package:flutter/material.dart';

class IssueAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Issue')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
            ),
            // Add other fields here
            ElevatedButton(
              onPressed: () {
                // Save issue logic
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
