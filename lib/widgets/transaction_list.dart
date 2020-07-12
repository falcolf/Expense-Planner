import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight * 0.6,
        child: this.transactions.isEmpty ? Column(
          children: <Widget>[
            Container(child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,), height: constraints.maxHeight * 0.5, padding: EdgeInsets.all(20),),
            SizedBox(height: constraints.maxHeight*0.1,),
            Text('No transactions to show!', style: Theme.of(context).textTheme.headline6,),
          ],
        )
            : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index){

            return Card(
              elevation: 6,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(padding:EdgeInsets.all(6),child: FittedBox(child: Text('Rs. ${transactions[index].amt}'),)),
                ),
                title: Text(transactions[index].title, style: Theme.of(context).textTheme.headline6),
                subtitle: Text(DateFormat.yMMMd().format(transactions[index].date), style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                trailing:
                  MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(onPressed:  () => deleteTransaction(transactions[index].id), icon: Icon(Icons.delete), label: Text("Delete"))
                      : IconButton(icon: Icon(Icons.delete), onPressed: () => deleteTransaction(transactions[index].id)),
              ),
            );
          },
        ),
      );
    },);

  }
}
