import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final amount = amountController.text;
                final description = descriptionController.text;
                Navigator.of(context).pop();
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
