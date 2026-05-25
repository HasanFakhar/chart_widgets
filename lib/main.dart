import 'package:flutter/material.dart';
import '../widgets/line_chart.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: 
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 2,
              child: MyLineChart()),
          )
        ),
      ),
    );
  }
}
