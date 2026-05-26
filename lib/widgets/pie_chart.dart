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
    bool isLoading = false;


  @override
  void initState() {
    super.initState();
    productController = ProductController();
    fetchData();

  }

  @override
  void didUpdateWidget(MyPieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stock != widget.stock) {
      fetchData();
    }
  }


  void fetchData() async {
    isLoading = true;
    try {
      Map<String, int> fetchedData = widget.stock
          ? await productController.stockByCategory()
          : await productController.countByRating();

      setState(() {
        dataPoints = fetchedData;
        isLoading = false;
        print ('Fetched data: $dataPoints');
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
static const _palette = [
  Color(0xFFFF9800), // orange
  Color(0xFFE53935), // red
  Color(0xFFFFB74D), // light orange
  Color(0xFFEF9A9A), // light red
  Color(0xFFE65100), // deep orange
  Color(0xFFB71C1C), // deep red
  Color(0xFFFFCC02), // amber
  Color(0xFFFF1744), // bright red
  Color(0xFFFFA726), // soft orange
  Color(0xFFD50000), // crimson
  Color(0xFFFFD54F), // pale amber
  Color(0xFFC62828), // dark crimson
];
  
  @override
  Widget build(BuildContext context){
    

    final entries = dataPoints.entries.toList();

    return isLoading ? const Center(child: CircularProgressIndicator()) : PieChart(
      
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
        centerSpaceRadius: 50,
      sections: entries.asMap().entries.map((mapEntry) {
            final index = mapEntry.key;
            final entry = mapEntry.value;

            final pietitle = widget.stock
                ? '${entry.key}: ${entry.value}'
                : '${entry.key} stars: ${entry.value}';

            final value = entry.value.toDouble();

            final isTouched = index == touchedIndex;

          return PieChartSectionData(
            radius: isTouched ? 100 : 80,
            value: value,
            title: isTouched ? pietitle : '',
            titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), 
            color: _palette[index % _palette.length],
          );
        }).toList(),
      ),
    );
  }
}

