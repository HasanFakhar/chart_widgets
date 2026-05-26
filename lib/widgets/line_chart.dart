import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/product_controller.dart';

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
  Widget build(BuildContext context) {

     if (dataPoints.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }
  
    return LineChart(
      LineChartData(
        backgroundColor: widget.prices 
        ? const Color(0xff37434d)  
        : const Color.fromARGB(0, 255, 255, 255), 
        lineBarsData: [
          LineChartBarData(
            spots: _generateFlSpots(),
            isCurved: false,
            gradient: const LinearGradient(
              colors: [Colors.cyanAccent,Colors.lightBlueAccent],
            ),
            barWidth: 4,
          ),
        ],
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: true,
            verticalInterval: 1,
            horizontalInterval: 1,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: widget.prices ? const Color(0xff37434d) :const Color.fromARGB(0, 255, 255, 255),
                strokeWidth: 1,
              );
            },
            getDrawingHorizontalLine: (value) {
              return  FlLine(
                color: widget.prices ? const Color(0xff37434d) :const Color.fromARGB(0, 255, 255, 255),
                strokeWidth: 1,
              );
            },
      ),
        
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            axisNameSize: 16,
            axisNameWidget: const Text('Brand', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            interval: 1, 
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
             
              if (value != index.toDouble()) return const SizedBox.shrink();
              if (index < 0 || index >= dataPoints.keys.length) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Transform.rotate(
                  angle: -0.4,
                  child: Text(
                    dataPoints.keys.toList()[index],
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              );
            },
          ),
),
          leftTitles: AxisTitles(
            axisNameSize: 18,
            axisNameWidget: Text(widget.prices ? 'Price' : 'Rating'
             , style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            sideTitles: SideTitles(showTitles: true, reservedSize: 40,),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
            
          ),
          
        ),
         borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      ),
    );
  }
}