import "package:flutter/material.dart";
import "../models/transaction.dart";

class UserTransactions extends StatefulWidget {

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  final List<Transaction> _userTransactions = [
    Transaction(id: 'tx1', title: 'rasp pi', amt: 5000, date: DateTime.now()),
    Transaction(id: 'tx2', title: 'servo', amt: 200, date: DateTime.now()),
  ];

  void addTransaction(String title, String amt){
    setState(() {
      _userTransactions.add(
          Transaction(id:'tx3', title: title, amt: double.parse(amt), date: DateTime.now())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
