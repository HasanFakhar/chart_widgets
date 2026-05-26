import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/product_controller.dart';
import 'dart:math';

class MyLineChart extends StatefulWidget {
  String category;
  bool prices;
 

  MyLineChart({super.key, this.category = 'all', this.prices = true});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  Map<String, double> dataPoints = {};
  late ProductController productController;
   bool isLoading = false;


  List<FlSpot> _generateFlSpots() {
    return dataPoints.entries
        .map((entry) => FlSpot(
              dataPoints.keys.toList().indexOf(entry.key).toDouble(),
              entry.value,
            ))
        .toList();
  }

  void fetchData() async {
          isLoading = true;
    try {
      List products;
      if (widget.category == 'all') {
        products = await productController.fetchAllProducts();
      } else {
        products = await productController.fetchByCategory(widget.category);
      }

      setState(() {
        dataPoints = {
          for (var product in products)
            product.brand ?? 'Unknown': widget.prices
                ? product.price.toDouble()
                : product.rating.toDouble(),
        };
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    productController = ProductController();
    fetchData();
  }
  @override
void didUpdateWidget(MyLineChart oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.category != widget.category || oldWidget.prices != widget.prices) {
    fetchData();
  }
}
static const _bg         = Color(0xFF2C1A00);   // dark brown-orange bg
static const _gridLine   = Color(0xFF5C3A00);   // muted orange grid
static const _border     = Color(0xFFFF9800);   // orange border
static const _lineStart  = Color(0xFFFF9800);   // orange gradient start
static const _lineEnd    = Color(0xFFFFCC02);   // amber gradient end

  @override
  Widget build(BuildContext context) {

     if (dataPoints.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }
  
    return isLoading ? const Center(child: CircularProgressIndicator()) : LineChart(
  LineChartData(
    minY: 0,
    maxY: widget.prices ? (dataPoints.values.reduce((a, b) => a > b ? a : b) * 1.2) : 5,
    backgroundColor: widget.prices ? const Color.fromARGB(255, 173, 101, 0) : const Color.fromARGB(0, 180, 90, 38),
    lineBarsData: [
      LineChartBarData(
        spots: _generateFlSpots(),
        isCurved: false,
        gradient: const LinearGradient(colors: [_lineStart, _lineEnd]),
        barWidth: 4,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
            radius: 4,
            color: _lineEnd,
            strokeColor: _border,
            strokeWidth: 1.5,
          ),
        ),
      ),
    ],
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: false,
      drawVerticalLine: false,
      verticalInterval: 1,
      horizontalInterval: 1,
      getDrawingVerticalLine: (_) => FlLine(color: _gridLine, strokeWidth: 1),
      getDrawingHorizontalLine: (_) => FlLine(color: _gridLine, strokeWidth: 1),
    ),
    titlesData: FlTitlesData(
      bottomTitles: AxisTitles(
        axisNameSize: 16,
        axisNameWidget: const Text('Brand',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0))),
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          interval: 1,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (value != index.toDouble()) return const SizedBox.shrink();
            if (index < 0 || index >= dataPoints.keys.length) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Transform.rotate(
                angle: -pi / 2,
                child: Text(
                  dataPoints.keys.toList()[index],
                  style: const TextStyle(fontSize: 11, color: Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.right,
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        axisNameSize: 18,
        axisNameWidget: Text(
          widget.prices ? 'Price  (\$)' : 'Rating (*)',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
          
          
        ),
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          getTitlesWidget: (value, meta) => Text(
            widget.prices ? '\$${value.toInt()}' : value.toStringAsFixed(1),
            style: const TextStyle(fontSize: 11, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: _border),
    ),
  ),
);
  }
}