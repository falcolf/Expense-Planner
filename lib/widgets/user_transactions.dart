import "package:flutter/material.dart";
import "../models/transaction.dart";
import "./new_transaction.dart";
import "./transaction_list.dart";

class UserTransactions extends StatefulWidget {

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  final List<Transaction> _userTransactions = [
    Transaction(id: 'tx1', title: 'rasp pi', amt: 5000, date: DateTime.now()),
    Transaction(id: 'tx2', title: 'servo', amt: 200, date: DateTime.now()),
  ];

  void addTransaction(String title, double amt){
    setState(() {
      _userTransactions.add(
          Transaction(
              id:DateTime.now().toString(),
              title: title,
              amt: amt,
              date: DateTime.now()
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(this.addTransaction),
        TransactionList(this._userTransactions)
      ],
    );
  }
}
