import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "./transaction.dart";

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
      home: MyHomePage(title: 'Expense Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> transactions = [
    Transaction(id: 'tx1', title: 'rasp pi', amt: 5000, date: DateTime.now()),
    Transaction(id: 'tx2', title: 'servo', amt: 200, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              color: Colors.blue,
              width: double.infinity,
              child: Text('Chart'),
            ),

            Column(
              children: transactions.map((tx) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                        ),
                        width: 120,
                        child: Text(
                          'Rs. ${tx.amt}/-',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(tx.title, style: TextStyle(fontSize: 18)),
                          Text(DateFormat.yMMMd().format(tx.date), style: TextStyle(fontSize: 12, color: Colors.blueGrey))
                        ],
                      ),
                    ],
                  ),
                  elevation: 5,
                );
              }).toList(),

            )
          ],
        )
      ),
    );
  }
}
