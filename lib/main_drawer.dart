import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/pp.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Ali Iktider Sayam',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15,),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.blue,
              size: 35,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          SizedBox(height: 5,),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
              size: 35,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onTap: () {
               Navigator.of(context).pushNamed('/settings');
            },
          ),
           SizedBox(height: 5,),
          ListTile(
            leading: Icon(
              Icons.contact_mail,
              color: Colors.blue,
              size: 35,
            ),
            title: Text(
              'Contacts',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onTap: () {
               Navigator.of(context).pushNamed('/contact');
            },
          ),
        ],
      ),
    );
  }
}
