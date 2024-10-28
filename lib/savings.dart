import 'package:flutter/material.dart';
import 'savingclass.dart';
import 'savings_database.dart';

final dbHelper = DatabaseHelper();

void main() {
  runApp(SavingsApp());
}

class SavingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savings App',
      home: SavingsHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SavingsHome extends StatefulWidget {
  @override
  _SavingsHomeState createState() => _SavingsHomeState();
}

class _SavingsHomeState extends State<SavingsHome> {
  List<SavingsGoal> goals = [];

  @override
  void initState() {
    super.initState();
    _loadGoals(); // Load goals when the app starts
  }

  void _loadGoals() async {
    final loadedGoals =
        await dbHelper.getGoals(); // Get saved goals from database
    setState(() {
      goals = loadedGoals; // Update the in-memory list
    });
  }

  void _addGoal(SavingsGoal goal) async {
    await dbHelper.saveGoal(goal);
    setState(() {
      goals.add(goal);
    });
  }

  void _editGoal(int index, SavingsGoal goal) async {
    await dbHelper.saveGoal(goal);
    setState(() {
      goals[index] = goal;
    });
  }

  void _deletegoal(int index) async {
    await dbHelper.deleteGoal(index);
    setState(() {
      goals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text('Savings Tracker',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: goals.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                goals[index].name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Saved: \$${goals[index].savedAmount} of \$${goals[index].targetAmount}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  LinearProgressIndicator(
                    value: goals[index].progress,
                    backgroundColor: Colors.red,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                    //color: Colors.green,
                  ),
                  /*IconButton(
                    icon: Icon(
                      Icons.save,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    onPressed: () => dbHelper.saveSettings(goals[index].name,
                        goals[index].targetAmount, goals[index].savedAmount),
                  ),*/
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    onPressed: () => _deletegoal(index),
                  ),
                ],
              ),
              onTap: () => _showEditGoalDialog(index),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGoalDialog(),
        child: Icon(
          Icons.add,
          //color: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
