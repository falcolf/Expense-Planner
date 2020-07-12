import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTxn;
  NewTransaction(this.addTxn);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitTxn(){

    if (this._titleController.text.isEmpty || this._amountController.text.isEmpty || this._selectedDate == null)
      return;

    String title = this._titleController.text;
    double amt = double.parse(this._amountController.text);
    DateTime date = this._selectedDate;

    if (title.isEmpty || amt<=0){
      return;
    }
    widget.addTxn(title, amt, date);
    Navigator.of(context).pop();
  }

  void _datePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null)
        return;
      setState(() {
        this._selectedDate = pickedDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: this._titleController,
                    onSubmitted: (_) => _submitTxn(),
                    autofocus: true,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    controller: this._amountController,
                    onSubmitted: (_) => _submitTxn(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text(this._selectedDate == null ? 'No date chosen!': DateFormat.yMMMd().format(this._selectedDate))),
                        Platform.isIOS
                            ? CupertinoButton(
                          child: Text('Choose Date', style: TextStyle(color: Theme.of(context).primaryColorDark),),
                          onPressed: _datePicker,
                        )
                            : FlatButton(
                          child: Text('Choose Date', style: TextStyle(color: Theme.of(context).primaryColorDark),),
                          onPressed: _datePicker,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).textTheme.button.color,
                    padding: EdgeInsets.all(10),
                    child: Text('Add Transaction'),
                    onPressed: _submitTxn,
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
