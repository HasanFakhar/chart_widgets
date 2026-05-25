import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/product_controller.dart';



class MyLineChart extends StatefulWidget {

    ProductController productController = ProductController();
    String category; // will be used to fetch products by category and display in the chart
    bool prices; // if true, show price data; if false, show rating data

    
    MyLineChart({super.key, this.category='all', this.prices=true});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
 Map<String, double> dataPoints = {}; // to hold the data points for the chart

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
              product.title : widget.prices
                  ? product.price.toDouble()
                  : product.rating.toDouble(),
          };
        });

    } catch (e) {
      print('Error fetching data: $e');
    }

    print('Data points: $dataPoints'); // Debug print to check the data points
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is initialized
  }
  
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints.entries
                .map((entry) => FlSpot(
                      dataPoints.keys.toList().indexOf(entry.key).toDouble(),
                      entry.value,
                    ))
                .toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
          ),
        ],
      ),
    );
  }

}