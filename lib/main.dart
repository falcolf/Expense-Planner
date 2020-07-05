import "package:flutter/material.dart";
import "widgets/new_transaction.dart";
import "widgets/transaction_list.dart";
import "widgets/chart.dart";
import "models/transaction.dart";

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
              )
            )),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 15,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(color: Colors.white)
        ),
      ),
      home: MyHomePage('Expense Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String title;
  MyHomePage(this.title);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    //Transaction(id: 'tx1', title: 'rasp pi', amt: 500, date: DateTime.now().subtract(Duration(days: 1))),
    //Transaction(id: 'tx2', title: 'servo', amt: 200, date: DateTime.now().subtract(Duration(days: 4))),
  ];

  void _addTransaction(String title, double amt, DateTime date){
    setState(() {
      this._userTransactions.add(
        Transaction(
            id:DateTime.now().toString(),
            title: title,
            amt: amt,
            date: date,
        )
      );
    });
  }

  void newTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(this._addTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(tx.date.subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: <Widget>[
          IconButton(onPressed: () => newTransaction(context), icon: Icon(Icons.add),)
        ],
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Chart(_recentTransactions),
              ),
              TransactionList(this._userTransactions),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => newTransaction(context),
          child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

