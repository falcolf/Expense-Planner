import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: this.transactions.isEmpty ? Column(
        children: <Widget>[
          Container(child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,), height: 150, padding: EdgeInsets.all(20),),
          SizedBox(height: 10,),
          Text('No transactions to show!', style: Theme.of(context).textTheme.headline6,),
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index){
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
                      color: Theme.of(context).primaryColorLight,
                      width: 2,
                    ),
                  ),
                  width: 120,
                  child: Text(
                    'Rs. ${transactions[index].amt}/-',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(transactions[index].title, style: Theme.of(context).textTheme.headline6),
                    Text(DateFormat.yMMMd().format(transactions[index].date), style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic))
                  ],
                ),
              ],
            ),
            elevation: 5,
          );
        },
      ),
    );
  }
}
