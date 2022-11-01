import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendindPctOfTotal;

  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendindPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          height: 20,
          child:
              FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
      const SizedBox(
        height: 4,
      ),
      // ignore: sized_box_for_whitespace
      Container(
        height: 60,
        width: 10,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20)),
            ),
            FractionallySizedBox(
                heightFactor: spendindPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ))
          ],
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(label)
    ]);
  }
}
