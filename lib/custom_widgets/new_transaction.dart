import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const NewTransaction(this.addNewTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate = null;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // ignore: avoid_unnecessary_containers
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date chosen...'
                        : DateFormat.yMd().format(_selectedDate!)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10, top: 0, right: 0, bottom: 0),
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: _presentDatePicker,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        label: Text('Choose date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ))),
                  )
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 0, top: 40, right: 0, bottom: 0),
              height: 40,
              child: ElevatedButton(
                onPressed: submitData,
                child: const Text('Add Transaction'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
