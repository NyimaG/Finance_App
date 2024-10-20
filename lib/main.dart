import 'package:flutter/material.dart';
import 'addExpenses.dart';
import 'expense.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Expense> expenses = [];
  double currentBalance = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPlusButtonPressed() async {
    final newExpense = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddExpensePage()),
    );
    if (newExpense != null) {
      setState(() {
        expenses.add(newExpense);
        if (newExpense.isIncome) {
          currentBalance += double.parse(newExpense.amount);
        } else {
          currentBalance -= double.parse(newExpense.amount);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: <Widget>[
                _buildHomeContent(),
                _buildAnalyticsContent(),
                _buildSavingsContent(),
              ],
            ),
            if (_selectedIndex == 0)
              Positioned(
                bottom: 10,
                right: 185,
                child: FloatingActionButton(
                  onPressed: _onPlusButtonPressed,
                  child: Icon(Icons.add),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home),
            label: 'Home Page',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics),
            selectedIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.savings),
            selectedIcon: Icon(Icons.savings),
            label: 'Savings',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(25.0),
            color: Colors.lightBlueAccent,
            child: Text(
              'Current Balance: \$${currentBalance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 30.0, color: Colors.amber),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            color: Colors.lightBlueAccent,
            child: Text(
              'Expenses:',
              style: TextStyle(fontSize: 30.0, color: Colors.amber),
            ),
          ),
          _buildExpenseList('Food', expenses),
          _buildExpenseList('Rent', expenses),
          _buildExpenseList('Utilities', expenses),
          _buildExpenseList('Leisure/Entertainment', expenses),
          _buildExpenseList('Income', expenses),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildExpenseList(String categoryLabel, List<Expense> expenses) {
    List<Expense> filteredExpenses =
        expenses.where((expense) => expense.category == categoryLabel).toList();

    return Column(
      children: [
        Text(
          categoryLabel,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredExpenses.length,
          itemBuilder: (context, index) {
            final expense = filteredExpenses[index];
            return ListTile(
              title: Text('${expense.description}: \$${expense.amount}'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnalyticsContent() {
    return Center(
      child: Text(
        'Analytics Tab',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildSavingsContent() {
    return Center(
      child: Text(
        'Savings Tab',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
