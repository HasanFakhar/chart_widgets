import 'package:flutter/material.dart';
import '../widgets/line_chart.dart';
import '../widgets/pie_chart.dart';
import  '../widgets/combined_chart.dart';
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

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: MyPieChart(stock: false),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: MyPieChart(stock: true),
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Count by Rating',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Stock Distribution',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                 Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(top:20),
                  child: AspectRatio(
                    aspectRatio: 2.5,
                    child:LineBarChart()
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