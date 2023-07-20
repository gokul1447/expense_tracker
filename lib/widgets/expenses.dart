import 'package:expensive_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

import 'package:expensive_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expensive_tracker/models/expense.dart';
import 'package:expensive_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course paid',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _addoverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => newexpense(
              onaddexpense: _addexpense,
            ));
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Deleted...'),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  void _addexpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 35),
            child: IconButton(
              onPressed: _addoverlay,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
           Chart(expenses: _registeredExpenses),
          Expanded(
            child: ExpensesList(
                expenses: _registeredExpenses, onremoveExpense: _removeExpense),
          ),
        ],
      ),
    );
  }
}
