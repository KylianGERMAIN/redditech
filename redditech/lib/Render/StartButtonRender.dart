import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import '../Request/LoginToken.dart';

class PageStart extends StatefulWidget {
  PageStart({Key key}) : super(key: key);

  @override
  Start createState() => Start();
}

class Start extends State<PageStart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redditech',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: const Text('Redditech'),
        ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                ),
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginToken()));
                },
                child: const Text('Login with Reddit \u{279C}'),
              ),
              Text('Kylian GERMAIN, Antoine Vergez EPITECH 2024')
            ]
          ),
        )
      )
      )
    );
  }
}
