import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/product_controller.dart';

class MyLineChart extends StatefulWidget {
  ProductController productController = ProductController();
  String category;
  bool prices;

  MyLineChart({super.key, this.category = 'all', this.prices = true});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  Map<String, double> dataPoints = {};

  List<FlSpot> _generateFlSpots() {
    return dataPoints.entries
        .map((entry) => FlSpot(
              dataPoints.keys.toList().indexOf(entry.key).toDouble(),
              entry.value,
            ))
        .toList();
  }

  void fetchData() async {
    try {
      List products;
      if (widget.category == 'all') {
        products = await widget.productController.fetchAllProducts();
      } else {
        products = await widget.productController.fetchByCategory(widget.category);
      }

      setState(() {
        dataPoints = {
          for (var product in products)
            product.brand ?? 'Unknown': widget.prices
                ? product.price.toDouble()
                : product.rating.toDouble(),
        };
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: _generateFlSpots(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            interval: 1, 
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
             
              if (value != index.toDouble()) return const SizedBox.shrink();
              if (index < 0 || index >= dataPoints.keys.length) return const SizedBox.shrink();

              return Transform.rotate(
                angle: -0.4,
                child: Text(
                  dataPoints.keys.toList()[index],
                  style: const TextStyle(fontSize: 11),
                ),
              );
            },
          ),
),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40,),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
    );
  }
}