import '../controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineBarChart extends StatefulWidget {
  @override
  _LineBarChartState createState() => _LineBarChartState();
}

class _LineBarChartState extends State<LineBarChart> {
  Map<String, double> lineData = {};
  Map<String, double> barData = {};
  bool isLoading = false;
  String? errorMessage;

  late ProductController productController;

  @override
  void initState() {
    productController = ProductController();
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      List products = await productController.fetchAllProducts();

    setState(() {
          final Map<String, double> priceSum = {};
          final Map<String, double> ratingSum = {};
          final Map<String, int> count = {};

          for (var product in products) {
            final category = product.category ?? 'Unknown';
            priceSum[category]  = (priceSum[category]  ?? 0) + product.price.toDouble();
            ratingSum[category] = (ratingSum[category] ?? 0) + product.rating.toDouble();
            count[category]     = (count[category]     ?? 0) + 1;
          }

          lineData = {
            for (var category in count.keys)
              category: priceSum[category]! / count[category]!,
          };
          barData = {
            for (var category in count.keys)
              category: ratingSum[category]! / count[category]!,
          };

          isLoading = false;
        });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        isLoading = false;
      });
    }
  }

  List<_ChartData> _getLineChartData() =>
      lineData.entries.map((e) => _ChartData(e.key, e.value)).toList();

  List<_ChartData> _getBarChartData() =>
      barData.entries.map((e) => _ChartData(e.key, e.value)).toList();

 @override
Widget build(BuildContext context) {
  if (isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (errorMessage != null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage!, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: fetchData, child: const Text('Retry')),
        ],
      ),
    );
  }

  if (lineData.isEmpty && barData.isEmpty) {
    return const Center(child: Text('No data available'));
  }

  return SfCartesianChart(
    primaryXAxis: CategoryAxis(
      labelRotation: -90,
      labelStyle: const TextStyle(fontSize: 10),
    ),
    primaryYAxis: NumericAxis(
      name: 'priceAxis',
      title: AxisTitle(text: 'Price (\$)'),
      labelFormat: '\${value}',
    ),
    axes: [
      NumericAxis(
        name: 'ratingAxis',
        opposedPosition: true,
        title: AxisTitle(text: 'Rating'),
        minimum: 0,
        maximum: 5,
        interval: 1,
      ),
    ],
    legend: Legend(isVisible: true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <CartesianSeries>[
      ColumnSeries<_ChartData, String>(
        name: 'Rating',
        dataSource: _getBarChartData(),
        xValueMapper: (d, _) => d.label,
        yValueMapper: (d, _) => d.value,
        yAxisName: 'ratingAxis',
        color: Colors.orange,
        borderRadius: BorderRadius.circular(4),
        dataLabelSettings: const DataLabelSettings(isVisible: false),
      ),
      LineSeries<_ChartData, String>(
        name: 'Price',
        dataSource: _getLineChartData(),
        xValueMapper: (d, _) => d.label,
        yValueMapper: (d, _) => d.value,
        yAxisName: 'priceAxis',
        color: Colors.blue,
        width: 3,
        markerSettings: const MarkerSettings(isVisible: true),
      ),
    ],
  );
}
}

class _ChartData {
  final String label;
  final double value;
  _ChartData(this.label, this.value);
}