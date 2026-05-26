import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/product_controller.dart';


class MyPieChart extends StatefulWidget {

  bool stock; //true for stock, false for rating


    MyPieChart({super.key, required this.stock});



  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart>{


  late ProductController productController;
  Map<String, int> dataPoints = {};

  @override
  void initState() {
    super.initState();
    productController = ProductController();
    fetchData();

  }

  void fetchData() async {
    try {
      Map<String, int> fetchedData = widget.stock
          ? await productController.stockByCategory()
          : await productController.countByRating();

      setState(() {
        dataPoints = fetchedData;
        print ('Fetched data: $dataPoints');
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  
  @override
  Widget build(BuildContext context){

    return PieChart(
      
      PieChartData(
        centerSpaceRadius: 0,
        sections: dataPoints.entries.map((entry) {
          final pietitle = widget.stock ? '${entry.key}: ${entry.value}' : '${entry.key} stars: ${entry.value}';
          final value = entry.value.toDouble();
          return PieChartSectionData(
            radius: 150,
            value: value,
            title: pietitle,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), 
            color: Colors.primaries[dataPoints.keys.toList().indexOf(entry.key) % Colors.primaries.length],
          );
        }).toList(),
      ),
    );
  }
}

