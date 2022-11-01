import 'package:flutter/material.dart';
import 'package:personal_expenses_app/custom_widgets/chart.dart';
import 'package:personal_expenses_app/custom_widgets/new_transaction.dart';
import 'custom_widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Personal Expenses App'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    // ignore: unnecessary_new
    final newTransaction = new Transaction(
        id: Random().nextInt(100).toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () => {startAddNewTransaction(context)},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            // ignore: sized_box_for_whitespace
            Chart(_recentTransactions),
            TransactionList(
              _userTransactions,
              deleteTransaction: _deleteTransaction,
            )
          ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {startAddNewTransaction(context)},
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
