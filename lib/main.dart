// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project1/savings.dart';
import 'addExpenses.dart';
//import 'savingclass.dart';
import 'addExpenses.dart';
import 'expense.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[400],
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

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
                SavingsApp(),
                //_buildSavingsContent(),
              ],
            ),
            if (_selectedIndex == 0)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: FloatingActionButton(
                    onPressed: _onPlusButtonPressed,
                    child: Icon(Icons.add),
                  ),
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
            color: Colors.grey[400],
            child: Text(
              'Current Balance: \$${currentBalance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          _buildCategoryExpense('Food', expenses),
          _buildCategoryExpense('Rent', expenses),
          _buildCategoryExpense('Utilities', expenses),
          _buildCategoryExpense('Leisure/Entertainment', expenses),
          _buildCategoryExpense('Income', expenses),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryExpense(String categoryLabel, List<Expense> expenses) {
    List<Expense> filteredExpenses =
        expenses.where((expense) => expense.category == categoryLabel).toList();

    if (filteredExpenses.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      children: filteredExpenses.map((expense) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryLabel,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '${expense.description[0].toUpperCase()}${expense.description.substring(1).toLowerCase()}: \$${expense.amount}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      }).toList(),
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
