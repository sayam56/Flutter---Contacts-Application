import 'dart:async';

import 'package:contact_app/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import './readContacts.dart';
import './main_drawer.dart';
import './route_generator.dart';

List<Contact> contactsList = [];
List<Contact> contactsListFilter = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

    contactsList = new List();
    readContacts();
  }

  readContacts() async {
    final PermissionStatus permissionStatus = await _getPermission();
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
     if (permissionStatus == PermissionStatus.granted) {
         setState(() {
           contactsList=_contacts;
         });
    
     }
  }

  Future<PermissionStatus> _getPermission() async{
    final PermissionStatus permission = await Permission.contacts.status;
     if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              floating: true,
              pinned: true,
              expandedHeight: 150,
              snap: true,
              actionsIconTheme: IconThemeData(opacity: 0.5),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/bg.jpg',
                  fit: BoxFit.cover,
                ),
                title: Text('Contacts'),
              ),
            ),
            SliverFillRemaining(
              child: Center(
                child: Stack(
                  children: <Widget>[
                   // SearchWidget(),
                    ReadingContacts(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

