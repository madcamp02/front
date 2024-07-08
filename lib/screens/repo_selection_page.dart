import 'package:flutter/material.dart';
import '../models/owner.dart';
import '../models/repository.dart';
import 'main_page.dart';

class RepoSelectionPage extends StatelessWidget {
  final List<Owner> owners = [
    Owner(name: 'My Repos', repositories: [
      Repository(name: 'repository 1'),
      Repository(name: 'repository 2'),
      Repository(name: 'repository 3'),
    ]),
    Owner(name: 'My Organization', repositories: [
      Repository(name: 'Organization 1'),
      Repository(name: 'Organization 2'),
      Repository(name: 'Organization 3'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF301934),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/gitcat_logo.png', // Make sure to have your logo asset here
              height: 30,
            ),
            SizedBox(width: 8),
            Text(
              'GitCat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFF301934),
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: owners.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'My',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (index == 0) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Repos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (index == 1) Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    'My Organization',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(color: Colors.white),
                ExpansionTile(
                  title: Text(
                    owners[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  children: owners[index].repositories.map((repo) {
                    return ListTile(
                      title: Text(
                        repo.name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        // Navigate to Main Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
