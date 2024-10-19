import 'package:flutter/material.dart';
import 'expense.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;

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
                  DropdownMenuItem(
                    value: 'Income',
                    child: Text('Income'),
                  ),
                  DropdownMenuItem(
                    value: 'Food',
                    child: Text('Food'),
                  ),
                  DropdownMenuItem(
                    value: 'Rent',
                    child: Text('Rent'),
                  ),
                  DropdownMenuItem(
                    value: 'Utilities',
                    child: Text('Utilities'),
                  ),
                  DropdownMenuItem(
                    value: 'Leisure/Entertainment',
                    child: Text('Leisure/Entertainment'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final amount = amountController.text;
                  final description = descriptionController.text;
                  final category = selectedCategory;
                  if (amount.isNotEmpty &&
                      description.isNotEmpty &&
                      category != null) {
                    final newExpense = Expense(
                      amount: amount,
                      description: description,
                      category: category,
                      isIncome: category ==
                          'Income', 
                    );
                    Navigator.of(context).pop(newExpense);
                  }
                },
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
