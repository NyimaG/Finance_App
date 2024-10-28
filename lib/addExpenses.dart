// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'expense.dart';

class AddExpensePage extends StatefulWidget {
  final double currentBalance;

  const AddExpensePage({Key? key, required this.currentBalance})
      : super(key: key);

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;

  void _addExpense() {
    final amountText = amountController.text;
    final description = descriptionController.text;
    final category = selectedCategory;

    if (amountText.isNotEmpty && description.isNotEmpty && category != null) {
      final amount = double.tryParse(amountText);

      if (amount == null) {
        _showError('Please enter a valid number for the amount.');
        return;
      }

      if (category != 'Income' && widget.currentBalance - amount < 0) {
        _showError('This expense will result in a negative balance.');
        return;
      }

      final newExpense = Expense(
        amount: amountText,
        description: description,
        category: category,
        isIncome: category == 'Income',
      );

      Navigator.of(context).pop(newExpense);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Income/Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'Income', child: Text('Income')),
                  DropdownMenuItem(value: 'Food', child: Text('Food')),
                  DropdownMenuItem(value: 'Rent', child: Text('Rent')),
                  DropdownMenuItem(
                      value: 'Utilities', child: Text('Utilities')),
                  DropdownMenuItem(
                      value: 'Leisure/Entertainment',
                      child: Text('Leisure/Entertainment')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addExpense,
                child: Text('Add'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
