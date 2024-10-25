import 'package:flutter/material.dart';
import 'savingclass.dart';

void main() {
  runApp(SavingsApp());
}

class SavingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savings App',
      home: SavingsHome(),
    );
  }
}

class SavingsHome extends StatefulWidget {
  @override
  _SavingsHomeState createState() => _SavingsHomeState();
}

class _SavingsHomeState extends State<SavingsHome> {
  List<SavingsGoal> goals = [];

  void _addGoal(SavingsGoal goal) {
    setState(() {
      goals.add(goal);
    });
  }

  void _editGoal(int index, SavingsGoal goal) {
    setState(() {
      goals[index] = goal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Savings Goals')),
      body: ListView.builder(
          itemCount: goals.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(goals[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Saved: \$${goals[index].savedAmount} of \$${goals[index].targetAmount}'),
                  LinearProgressIndicator(
                    value: goals[index].progress,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                ],
              ),
              onTap: () => _showEditGoalDialog(index),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGoalDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddGoalDialog() {
    // Implement dialog to add a new goal
    String name = '';
    int targetAmount = 0;
    int savedAmount = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Savings Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(labelText: 'Goal Name'),
              ),
              TextField(
                onChanged: (value) => targetAmount = int.tryParse(value) ?? 0,
                decoration: InputDecoration(labelText: 'Target Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) => savedAmount = int.tryParse(value) ?? 0,
                decoration: InputDecoration(labelText: 'Saved Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  _addGoal(SavingsGoal(
                      name: name,
                      targetAmount: targetAmount,
                      savedAmount: savedAmount));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditGoalDialog(int index) {
    // Implement dialog to edit an existing goal

    String name = goals[index].name;
    int targetAmount = goals[index].targetAmount;
    int savedAmount = goals[index].savedAmount;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Savings Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(labelText: 'Goal Name'),
              ),
              TextField(
                onChanged: (value) => targetAmount = int.tryParse(value) ?? 0,
                decoration: InputDecoration(labelText: 'Target Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) => savedAmount = int.tryParse(value) ?? 0,
                decoration: InputDecoration(labelText: 'Saved Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  _editGoal(
                      index,
                      SavingsGoal(
                          name: name,
                          targetAmount: targetAmount,
                          savedAmount: savedAmount));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Change'),
            ),
          ],
        );
      },
    );
  }
}