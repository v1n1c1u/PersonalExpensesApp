import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(this.transactions,
      {super.key, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: transactions.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                      height: 175,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      margin: const EdgeInsets.all(20),
                      child: Row(children: <Widget>[
                        // ignore: avoid_unnecessary_containers
                        Container(
                          width: 100,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.green,
                            width: 1,
                          )),
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              '\$${transactions[index].amount.toString()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(transactions[index].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )),
                              Text(
                                  DateFormat().format(transactions[index].date))
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).errorColor)
                      ]));
                },
                itemCount: transactions.length,
              ));
  }
}
