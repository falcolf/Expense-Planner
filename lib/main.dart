import "dart:io";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
//import "package:flutter/services.dart";
import "widgets/new_transaction.dart";
import "widgets/transaction_list.dart";
import "widgets/chart.dart";
import "models/transaction.dart";

void main() => runApp(MyApp());
//void main(){
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([
//      DeviceOrientation.portraitDown,
//      DeviceOrientation.portraitUp
//    ]
//  );
//
//  runApp(MyApp());
//}

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

bool _showChart = false;

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

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
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

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text("Expense Planner"),
      trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => newTransaction(context),
                    child: Icon(CupertinoIcons.add),
                  )
                ],
      ),
    )
        :AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(onPressed: () => newTransaction(context), icon: Icon(Icons.add),)
      ],
    );

    final transactionsWidget = Container(
        height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height) * 0.7,
        child: TransactionList(this._userTransactions, this._deleteTransaction)
    );

    final _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final pageBody = SafeArea(
                      child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                            if (_isLandscape == true) Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Show Chart", style: Theme.of(context).textTheme.headline6),
                                  Switch.adaptive(value: _showChart, onChanged: (val){
                                    setState(() {
                                      _showChart = val;
                                    });
                                  }),
                                ],
                              ),
                              if (_isLandscape) _showChart
                                ? Container(
                                        height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height) * 0.7,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        child: Chart(_recentTransactions),
                                  )
                                : transactionsWidget,
                              if (!_isLandscape) Container(
                                  height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height) * 0.3,
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  child: Chart(_recentTransactions),
                                ),
                              if (!_isLandscape)transactionsWidget,
                            ],
                          )
                        ),
                      )
                    );

    return Platform.isIOS
            ? CupertinoPageScaffold(
                child: pageBody,
                navigationBar: appBar,
            ) //CupertinoPageScaffold
            : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButton: Platform.isIOS? Container()
          :FloatingActionButton(
          onPressed: () => newTransaction(context),
          child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

