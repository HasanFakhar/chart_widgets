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
    int touchedIndex = -1;


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

    final entries = dataPoints.entries.toList();

    return PieChart(
      
      PieChartData(
         pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }

              touchedIndex = pieTouchResponse
                  .touchedSection!.touchedSectionIndex;
            });
          },
          
        ),
        centerSpaceRadius: 0,
      sections: entries.asMap().entries.map((mapEntry) {
            final index = mapEntry.key;
            final entry = mapEntry.value;

            final pietitle = widget.stock
                ? '${entry.key}: ${entry.value}'
                : '${entry.key} stars: ${entry.value}';

            final value = entry.value.toDouble();

            final isTouched = index == touchedIndex;

          return PieChartSectionData(
            radius: isTouched ? 170 : 150,
            value: value,
            title: isTouched ? pietitle : '',
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), 
            color: Colors.primaries[dataPoints.keys.toList().indexOf(entry.key) % Colors.primaries.length],
          );
        }).toList(),
      ),
    );
  }
}

