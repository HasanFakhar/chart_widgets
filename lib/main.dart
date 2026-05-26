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

  String _lineCategory2 = 'laptops';
  bool _linePrices2 = false;

  bool _pieStock1 = false;
  bool _pieStock2 = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              // ── Line Chart 1 ───────────────────────────────────────
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
                  const Text('Prices'),
                  Switch(value: _linePrices1, onChanged: (v) => setState(() => _linePrices1 = v)),
                ],
              ),
              AspectRatio(
                aspectRatio: 2,
                child: MyLineChart(category: _lineCategory1, prices: _linePrices1),
              ),

              const SizedBox(height: 20),

              // ── Line Chart 2 ───────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _lineCategory2,
                      isExpanded: true,
                      items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (v) => setState(() => _lineCategory2 = v!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Prices'),
                  Switch(value: _linePrices2, onChanged: (v) => setState(() => _linePrices2 = v)),
                ],
              ),
              AspectRatio(
                aspectRatio: 2,
                child: MyLineChart(category: _lineCategory2, prices: _linePrices2),
              ),

              const SizedBox(height: 20),

        
                  
                     Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             _pieStock1 ? const Text('Stock') : const Text('Rating'),
                            Switch(value: _pieStock1, onChanged: (v) => setState(() => _pieStock1 = v)),
                          ],
                        ),
                        AspectRatio(aspectRatio: 2, child: MyPieChart(stock: _pieStock1)),
                      ],
                    ),
             
                 
                
              

              const SizedBox(height: 20),

              // ── Combined Chart ─────────────────────────────────────
              AspectRatio(
                aspectRatio: 2.5,
                child: LineBarChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}