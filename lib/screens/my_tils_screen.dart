import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/til.dart';
import '../widgets/til_card.dart';

class MyTILsScreen extends StatefulWidget {
  final String userGithubId;
  final String storedSecret = dotenv.get('GITCAT_SECRET');

  MyTILsScreen({required this.userGithubId});

  @override
  _MyTILsScreenState createState() => _MyTILsScreenState();
}

class _MyTILsScreenState extends State<MyTILsScreen> {
  List<TIL> tils = [];

  @override
  void initState() {
    super.initState();
    fetchTils();
  }

  Future<void> fetchTils() async {
    final response = await http.get(
      Uri.parse('http://34.47.114.222:3000/gitcat/fetch/tils?user_github_id=${widget.userGithubId}&gitcat_secret=${widget.storedSecret}'), // Adjust the URL accordingly
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        tils = (data['tils'] as List).map((tilData) => TIL.fromJson(tilData)).toList();
      });
      print('TILs fetched successfully: ${data['tils']}');
    } else {
      print(response.statusCode);
      print('Failed to fetch TILs');
    }
  }

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
