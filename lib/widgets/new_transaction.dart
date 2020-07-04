import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

  final Function addTxn;

  NewTransaction(this.addTxn);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitTxn(){
    String title = this.titleController.text;
    double amt = double.parse(this.amountController.text);

    if (title.isEmpty || amt<=0){
      return;
    }
    widget.addTxn(title, amt);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: this.titleController,
                onSubmitted: (_) => submitTxn(),
                //autofocus: true,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: this.amountController,
                onSubmitted: (_) => submitTxn(),
              ),
              FlatButton(
                child: Text('Add Transaction'),
                onPressed: submitTxn,
              )
            ],
          )
      ),
    );
  }
}
