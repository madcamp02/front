import 'package:flutter/material.dart';
import '../models/commit.dart';

class TILCard extends StatelessWidget {
  final Commit til;

  TILCard({required this.til});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              'COMMIT TITLE',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Date',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              '-----------------------------',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '-----------------------------',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '-----------------------------',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '-----------------------------',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '-----------------------------',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              children: [
                Chip(
                  label: Text(til.issue),
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
    );
  }
}
