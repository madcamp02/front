import 'package:flutter/material.dart';
import 'milestones_screen.dart';
import 'recent_commits_screen.dart';
import 'my_tils_screen.dart';

class MainPage extends StatelessWidget {
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
              'Review your Day',
              style: TextStyle(color: Color(0xFF8E5C9A), fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/cat1.png', height: 60), // Add your cat images here
                Image.asset('assets/cat2.png', height: 60),
                Image.asset('assets/cat3.png', height: 60),
                Image.asset('assets/cat4.png', height: 60),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 120,
                    child: Card(
                      color: Color(0xFF8E5C9A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.event_note, color: Colors.white, size: 40),
                          title: Text('Milestones', style: TextStyle(color: Colors.white, fontSize: 24)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MilestonesScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: Card(
                      color: Color(0xFF8E5C9A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.access_time, color: Colors.white, size: 40),
                          title: Text('Recent Commits', style: TextStyle(color: Colors.white, fontSize: 24)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RecentCommitsScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: Card(
                      color: Color(0xFF8E5C9A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.event_note, color: Colors.white, size: 40),
                          title: Text('My TILs', style: TextStyle(color: Colors.white, fontSize: 24)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyTILsScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
