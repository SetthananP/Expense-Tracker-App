import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/expense_model.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom,
        ),
        series: <CircularSeries>[
          PieSeries<Expense, String>(
            dataSource: expenses,
            xValueMapper: (Expense expense, _) => expense.category,
            yValueMapper: (Expense expense, _) => expense.amount,
            pointColorMapper: (Expense expense, _) =>
                _getCategoryColor(expense.category),
            legendIconType: LegendIconType.circle,
            dataLabelMapper: (Expense expense, _) =>
                '${expense.title}: ${expense.amount}',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.auto,
              textStyle: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.green;
      case 'Transportation':
        return Colors.blue;
      case 'Entertainment':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
