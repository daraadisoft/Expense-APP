import 'package:expense_app/features/add_expense/model/category_model.dart';
import 'package:expense_app/utils/app_color.dart';
import 'package:expense_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class GraphicWidget extends StatefulWidget {
  final double totalAmount;
  final List<CategoryModel> listCategory;
  final DateTime startDate;
  final DateTime endDate;

  const GraphicWidget(
      {required this.listCategory,
      required this.totalAmount,
      required this.startDate,
      required this.endDate});

  @override
  State<GraphicWidget> createState() => _GraphicWidgetState();
}

class _GraphicWidgetState extends State<GraphicWidget> {
  @override
  void initState() {
    super.initState();
    for (var action in widget.listCategory) {
      pieChartData[action.name.toString()] = action.amount ?? 0;
    }
  }

  Map<String, double> pieChartData = {};

  @override
  Widget build(BuildContext context) {
    return pieChart();
  }

  Widget pieChart() {
    return PieChart(
      dataMap: pieChartData,
      ringStrokeWidth: 30,
      chartType: ChartType.ring,
      centerText: widget.totalAmount.toString(),
      legendOptions:  LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: AppTheme.getTextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColor.black
        ),
      ),
      chartValuesOptions:  ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
        chartValueStyle: AppTheme.getTextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppColor.black
        )
      ),
      colorList: List.generate(widget.listCategory.length, (index) {
        var data = widget.listCategory[index];
        return AppColor.decodeColor(hex: data.color.toString());
      }),
    );
  }
}
