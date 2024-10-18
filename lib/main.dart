import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
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
  void _updateIncome() {
    setState(() {
      //this is where the income will update from the 'add screen'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 173, 38, 38),
        title: Text('MyFinanceTracker'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(25.0),
            //margin: EdgeInsets.all(10.0),
            color: Colors.grey,
            child: Text('Current Balance:',
                style: TextStyle(
                    fontSize: 30.0,
                    //backgroundColor: Colors.blue,
                    color: Colors.amber)),
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
              '\$10,000', //variable that stores balance will go here
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            //margin: EdgeInsets.all(10.0),
            color: Colors.grey,
            child: Text('Expenses:',
                style: TextStyle(
                    //decoration: TextDecoration.underline,
                    fontSize: 30.0,
                    //backgroundColor: Colors.blue,
                    color: Colors.amber)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            color: Colors.blue,
            child: Text(
              'Food: \$       ',
              style: TextStyle(
                  //decoration: TextDecoration.underline,
                  fontSize: 20.0,
                  //backgroundColor: Colors.blue,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            color: Colors.blue,
            child: Text(
              'Rent: \$       ',
              style: TextStyle(
                  //decoration: TextDecoration.underline,
                  fontSize: 20.0,
                  //backgroundColor: Colors.blue,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            color: Colors.blue,
            child: Text(
              'Utilities: \$    ',
              style: TextStyle(
                  //decoration: TextDecoration.underline,
                  fontSize: 20.0,
                  //backgroundColor: Colors.blue,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            color: Colors.blue,
            child: Text(
              'Leisure/Entertainment:  \$    ',
              style: TextStyle(
                  //decoration: TextDecoration.underline,
                  fontSize: 20.0,
                  //backgroundColor: Colors.blue,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
