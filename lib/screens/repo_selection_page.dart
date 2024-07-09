import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tuple/tuple.dart';
import '../models/owner.dart';
import '../models/repository.dart';
import 'main_page.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For making HTTP requests

class RepoSelectionPage extends StatefulWidget {
  final String userId;
  final String storedSecret = dotenv.get('GITCAT_SECRET');

  RepoSelectionPage({required this.userId});

  @override
  _RepoSelectionPageState createState() => _RepoSelectionPageState();
}

class _RepoSelectionPageState extends State<RepoSelectionPage> {
  List<Tuple2<Owner, List<Repository>>> ownersRepos = [];

  @override
  void initState() {
    super.initState();
    fetchRepositories();
  }

  Future<void> fetchRepositories() async {
    final response = await http.get(
      Uri.parse('http://34.64.230.8:3000/gitcat/retrieve/owners-repos?user_github_id=${widget.userId}&gitcat_secret=${widget.storedSecret}'),
    );
    print(response);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        ownersRepos = parseOwners(data['ownersRepos']);
      });
      print('Success to load repositories');
    } else {
      // Handle the error appropriately here
      print('Failed to load repositories');
    }
  }

  List<Tuple2<Owner, List<Repository>>> parseOwners(dynamic data) {
    final parsed = data as List;
    return parsed.map<Tuple2<Owner, List<Repository>>>((json) {
      var owner = Owner.fromJson(json['owner']);
      var repoList = (json['repoList'] as List)
          .map((repo) => Repository.fromJson(repo))
          .toList();
      return Tuple2(owner, repoList);
    }).toList();
  }

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
        child: ownersRepos.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: ownersRepos.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0)
                  Padding(
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
                if (index == 0)
                  Padding(
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
                if (index == 1)
                  Padding(
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
                    ownersRepos[index].item1.ownerName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  children: ownersRepos[index].item2.map((repo) {
                    return ListTile(
                      title: Text(
                        repo.repoName,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        // Navigate to Main Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage()),
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
