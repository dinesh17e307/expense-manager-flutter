import 'package:expensemanager/Widgets/Expenses_list/Expenses_list.dart';
import 'package:expensemanager/Widgets/NewExpeses.dart';
import 'package:flutter/material.dart';

import '../Models/expense.dart';

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
        title: 'sandwich',
        date: DateTime.now(),
        amount: '23',
        category: Category.food),
    Expense(
        title: 'laptop',
        date: DateTime.now(),
        amount: '123',
        category: Category.work),
    Expense(
        title: 'veggies',
        date: DateTime.now(),
        amount: '323',
        category: Category.leisure),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Expense ${expense.title} Deleted'),
      duration: Duration(milliseconds: 2000),
      action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  _openBottomModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(onAddExpense: _addExpense));
  }

  @override
  Widget build(context) {
    Widget mainContent =
        const Center(child: Text('No expense found, try adding some..'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expense: _registeredExpenses, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
        appBar: AppBar(title: Text('Expense Manager'), actions: [
          IconButton(onPressed: _openBottomModal, icon: Icon((Icons.add)))
        ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The shat'),
            Expanded(
              child: mainContent,
            )
          ],
        ));
  }
}
