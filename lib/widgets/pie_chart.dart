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
          : await productController.ratingByCategory();

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
        sections: dataPoints.entries.map((entry) {
          final value = entry.value.toDouble();
          return PieChartSectionData(
            value: value,
            title: '${entry.key}: ${entry.value}',
            color: Colors.primaries[dataPoints.keys.toList().indexOf(entry.key) % Colors.primaries.length],
          );
        }).toList(),
      ),
    );
  }
}

