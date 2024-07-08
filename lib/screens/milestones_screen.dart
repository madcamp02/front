import 'package:flutter/material.dart';
import '../models/milestone.dart';
import '../models/issue.dart';
import 'issue_edit_screen.dart';

class MilestonesScreen extends StatefulWidget {
  @override
  _MilestonesScreenState createState() => _MilestonesScreenState();
}

class _MilestonesScreenState extends State<MilestonesScreen> {
  int? _expandedIndex;

  final List<Milestone> milestones = [
    Milestone(name: 'Milestone 1', issues: [
      Issue(name: 'Issue 1'),
      Issue(name: 'Issue 2'),
    ]),
    Milestone(name: 'Milestone 2', issues: [
      Issue(name: 'Issue 3'),
    ]),
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
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: milestones.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                color: Color(0xFF8E5C9A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  key: Key(index.toString()),
                  initiallyExpanded: index == _expandedIndex,
                  title: Text(milestones[index].name, style: TextStyle(color: Colors.white, fontSize: 20)),
                  children: [
                    Column(
                      children: [
                        for (var issue in milestones[index].issues)
                          ListTile(
                            title: Text(issue.name, style: TextStyle(color: Colors.white)),
                            onTap: () {
                              // Navigate to Issue Edit Screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => IssueEditScreen(issue: issue)),
                              );
                            },
                          ),
                        ListTile(
                          title: Text('Add new issue', style: TextStyle(color: Colors.white)),
                          tileColor: Color(0xFFCDC3D0),
                          onTap: () {
                            // Add new issue logic here
                          },
                        ),
                      ],
                    ),
                  ],
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _expandedIndex = expanded ? index : null;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF8E5C9A),
        onPressed: () {
          // Add new milestone logic here
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
