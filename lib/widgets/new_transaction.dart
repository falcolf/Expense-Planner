import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {

  final Function addTxn;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTxn);

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
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: this.amountController,
              ),
              FlatButton(
                child: Text('Add Transaction'),
                onPressed: (){
                  addTxn(
                      this.titleController.text,
                      double.parse(this.amountController.text),
                  );
                },
              )
            ],
          )
      ),
    );
  }
}
