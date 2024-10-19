// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'addExpenses.dart';
import 'expense.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlueAccent,
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPlusButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpensePage()),
    );
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
              'Current Balance:',
              style: TextStyle(fontSize: 30.0, color: Colors.amber),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              '\$10,000',
              style: TextStyle(fontSize: 30),
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
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              _buildExpenseItem('Food'),
              _buildExpenseItem('Rent'),
              _buildExpenseItem('Utilities'),
              _buildExpenseItem('Leisure/Entertainment'),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
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

  Widget _buildExpenseItem(String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      color: Colors.blue,
      child: Center(
        child: Text(
          '$label: \$       ',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
  }
}
