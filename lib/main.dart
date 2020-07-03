import "package:flutter/material.dart";
import "widgets/user_transactions.dart";

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage('Expense Planner'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final String title;

  MyHomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blue,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text('Chart'),
              ),
              UserTransactions(),
            ],
          )
      ),
    );
  }
}

