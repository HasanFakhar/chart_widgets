import 'package:flutter/material.dart';
import '../widgets/line_chart.dart';
import '../widgets/pie_chart.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: MyLineChart(
                      category: 'smartphones',
                      prices: true,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: MyLineChart(
                      category: 'laptops',
                      prices: false,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: MyPieChart(stock: false),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: MyPieChart(stock: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}