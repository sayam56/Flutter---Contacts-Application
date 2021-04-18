import 'package:contact_app/profile-page.dart';
import 'package:flutter/material.dart';
import './main.dart';
import './profile-page.dart';
import './settings.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {


    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                MyHomePage()); //prebuilt page route krote hole => nahole direct function body
      case '/profile':
       
          return MaterialPageRoute(builder: (_) => Profile());
     
        return _errorRoute();

      case '/settings':
     
          return MaterialPageRoute(builder: (_) => Settings());
        
        return _errorRoute();

      case '/contact':
      
          return MaterialPageRoute(builder: (_) => MyHomePage());
        
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error Route Not Found'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
