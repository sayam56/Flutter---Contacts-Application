import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './main_drawer.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
       drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Profile Page',
              style: TextStyle(fontSize: 20),
            ),
            RaisedButton(
                child: Text('Google'),
                color: Colors.redAccent[100],
                onPressed: () {
                  _launchURL();
                })
          ],
        ),
      ),
    );
  }
}

void _launchURL() async {
  const url = 'https://www.google.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Couldn\'n Launch $url';
  }
}
