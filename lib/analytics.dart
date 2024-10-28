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
      if (!expense.isIncome) {
        categoryTotals[expense.category] =
            (categoryTotals[expense.category] ?? 0) +
                double.parse(expense.amount);
      }
    }

    double maxValue = categoryTotals.values.isNotEmpty
        ? categoryTotals.values.reduce((a, b) => a > b ? a : b)
        : 0;
    double maxY = maxValue + 1000;

    List<Expense> sortedExpenses = expenses
        .where((expense) => !expense.isIncome)
        .toList()
      ..sort(
          (a, b) => double.parse(b.amount).compareTo(double.parse(a.amount)));

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Total Spendings',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
            SizedBox(height: 35),
            Container(
              height: screenHeight / 2.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY,
                    barGroups: categoryTotals.entries.map((entry) {
                      return BarChartGroupData(
                        x: categoryTotals.keys.toList().indexOf(entry.key),
                        barRods: [
                          BarChartRodData(
                            toY: entry.value,
                            color: const Color.fromARGB(255, 91, 178, 221),
                            width: 15,
                            borderRadius: BorderRadius.circular(4),
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
                            return Text(category,
                                style: TextStyle(fontSize: 12));
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        tooltipMargin: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Most Expensive Expenses',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount:
                    sortedExpenses.length > 5 ? 5 : sortedExpenses.length,
                itemBuilder: (context, index) {
                  final expense = sortedExpenses[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(
                        expense.description,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(expense.category),
                      trailing: Text(
                        '\$${expense.amount}',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
