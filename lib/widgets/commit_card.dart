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
          MaterialPageRoute(builder: (context) => CommitDetailScreen(commit: commit, userGithubId: commit.ownerGithubId)),
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
                commit.commitMsg,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '----------------------------',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Owner ID: ${commit.ownerGithubId}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                'Repo ID: ${commit.repoGithubId}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                'Commit Date: ${commit.commitDate}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                'Issue IDs',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: commit.issueIdList.map((issue) {
                  return Chip(
                    label: Text(issue.toString()),
                    backgroundColor: Color(0xFFCDC3D0),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
