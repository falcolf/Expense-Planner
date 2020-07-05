import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String label;
  double amt;
  double pct;

  ChartBar({
    @required this.label,
    @required this.amt,
    @required this.pct,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(height: constraints.maxHeight * 0.15, child: FittedBox(child: Text('${amt.toStringAsFixed(0)}'))),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            height: constraints.maxHeight * 0.60,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color. fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: pct,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(height: constraints.maxHeight * 0.15,child: FittedBox(child: Text(label))),
        ],
      );
    },);

  }
}
