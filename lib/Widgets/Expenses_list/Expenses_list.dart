import 'package:expensemanager/Widgets/Expenses_list/Expenses_item.dart';
import 'package:flutter/material.dart';

import '../../Models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expense, required this.onRemoveExpense});

  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, indx) => Dismissible(
          background: Container(
            color: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withOpacity(0.75),
          ),
          key: UniqueKey(),
          onDismissed: (direction) {
            onRemoveExpense(expense[indx]);
          },
          child: ExpensesItem(expense[indx])),
    ));
  }
}
