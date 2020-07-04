import "package:flutter/material.dart";
import "widgets/new_transaction.dart";
import "widgets/transaction_list.dart";
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
          )
        )
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
    Transaction(id: 'tx1', title: 'rasp pi', amt: 5000, date: DateTime.now()),
    Transaction(id: 'tx2', title: 'servo', amt: 200, date: DateTime.now()),
  ];

  void _addTransaction(String title, double amt){
    setState(() {
      this._userTransactions.add(
        Transaction(
            id:DateTime.now().toString(),
            title: title,
            amt: amt,
            date: DateTime.now()
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
                color: Colors.blue,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text('Chart'),
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

