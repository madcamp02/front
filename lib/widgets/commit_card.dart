import 'package:flutter/material.dart';
import '../models/commit.dart';
import '../screens/commit_detail_screen.dart';

class CommitCard extends StatelessWidget {
  final Commit commit;

  CommitCard({required this.commit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CommitDetailScreen(commit: commit)),
        );
      },
      child: Card(
        color: Color(0xFF8E5C9A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commit.name,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '----------------------------',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                commit.username,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                commit.date,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Issue',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: [
                  Chip(
                    label: Text(commit.issue),
                    backgroundColor: Color(0xFFCDC3D0),
                  ),
                  Chip(
                    label: Text('Medium'),
                    backgroundColor: Color(0xFFCDC3D0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
