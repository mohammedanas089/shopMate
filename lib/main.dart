import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatorScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
            ),
            child: Text(
              'Stock',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
            ),
            child: Text(
              'Customer Track',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator Screen'),
      ),
      body: Center(
        child: Text(
          'This is the Calculator Screen!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Screen'),
      ),
      body: Center(
        child: Text(
          'This is the Data Screen!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
