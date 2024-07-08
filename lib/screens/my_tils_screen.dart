import 'package:flutter/material.dart';
import '../models/commit.dart';
import '../widgets/til_card.dart';

class MyTILsScreen extends StatelessWidget {
  final List<Commit> tils = [
    Commit(name: 'TIL 1', username: 'User1', date: 'Date1', issue: 'Issue1'),
    Commit(name: 'TIL 2', username: 'User2', date: 'Date2', issue: 'Issue2'),
  ];

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
              'What is your',
              style: TextStyle(color: Color(0xFFFF6F61), fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Error?!',
              style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search topic',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Implement search functionality
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tils.length,
                itemBuilder: (context, index) {
                  return TILCard(til: tils[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
