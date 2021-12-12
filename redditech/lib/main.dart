import 'package:flutter/material.dart';
import 'Render/StartButtonRender.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageStart(),
    );
  }
}
