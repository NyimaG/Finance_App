import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'expense.dart';

class AnalyticsPage extends StatelessWidget {
  final List<Expense> expenses;

  AnalyticsPage({required this.expenses});

  @override
  Widget build(BuildContext context) {
    Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) +
              double.parse(expense.amount);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total Spendings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: categoryTotals.entries.map((entry) {
                    return BarChartGroupData(
                      x: categoryTotals.keys.toList().indexOf(entry.key),
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          color: Colors.blue,
                          width: 15,
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (index, _) {
                          final category =
                              categoryTotals.keys.elementAt(index.toInt());
                          return Text(category, style: TextStyle(fontSize: 12));
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false, 
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 50,
                        getTitlesWidget: (value, _) {
                          return Text('\$${value.toStringAsFixed(0)}');
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

