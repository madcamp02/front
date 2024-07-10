import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'repo_selection_page.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _handleIncomingLinks() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        String? userId = uri.queryParameters['user_id'];
        String? receivedSecret = uri.queryParameters['gitcat_secret'];
        String? storedSecret = dotenv.get('GITCAT_SECRET');

        if (userId != null && receivedSecret != null) {
          print('userId : ${userId} !');
          if (receivedSecret == storedSecret) {
            print('secrets matched !');
            print('login success!');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RepoSelectionPage(userId: userId),
              ),
            );
          } else {
            print('        receivedSecret: '+receivedSecret + '        storedSecret: '+ storedSecret);
            throw('secrets do not match!');
            // Handle the case where secrets do not match (e.g., show an error message)
          }
        }else{
          throw('userId or secret is null -- never!');
        }
      }
    }, onError: (Object err) {
      print('Error occurred: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF301934), // Matching the background color from the image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 100), // Replace with your logo asset
            SizedBox(height: 20),
            Text(
              'GitCat',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                // Launch the GitHub authentication URL
                const url = 'http://34.47.114.222:3000/auth/github';
                //const url = 'http://localhost:3000/auth/github';
                launchUrlString(url);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Login with GitHub',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
