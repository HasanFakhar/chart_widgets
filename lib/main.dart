import 'package:flutter/material.dart';
import '../widgets/line_chart.dart';
import '../widgets/pie_chart.dart';
import '../widgets/combined_chart.dart';

void main() {
  runApp(const MainApp());
}

const List<String> categories = [
  'beauty', 'fragrances', 'furniture', 'groceries',
  'home-decoration', 'kitchen-accessories', 'laptops',
  'mens-shirts', 'mens-shoes', 'mens-watches', 'mobile-accessories',
];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _lineCategory1 = 'laptops';
  bool _linePrices1 = true;

  bool _pieStock1 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

           
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _lineCategory1,
                      isExpanded: true,
                      items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (v) => setState(() => _lineCategory1 = v!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<bool>(
                    value: _linePrices1,
                    items: const [
                      DropdownMenuItem(value: true,  child: Text('Price')),
                      DropdownMenuItem(value: false, child: Text('Rating')),
                    ],
                    onChanged: (v) => setState(() => _linePrices1 = v!),
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 2,
                child: MyLineChart(category: _lineCategory1, prices: _linePrices1),
              ),

              const SizedBox(height: 20),

        
            
              DropdownButton<bool>(
                value: _pieStock1,
                items: const [
                  DropdownMenuItem(value: false, child: Text('Rating')),
                  DropdownMenuItem(value: true,  child: Text('Stock')),
                ],
                onChanged: (v) => setState(() => _pieStock1 = v!),
              ),
              AspectRatio(
                aspectRatio: 1.4,
                child: MyPieChart(stock: _pieStock1),
              ),

              const SizedBox(height: 20),

              AspectRatio(
                aspectRatio: 1.5,
                child: LineBarChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}