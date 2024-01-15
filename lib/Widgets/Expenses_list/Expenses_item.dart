import 'package:expensemanager/Models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expenselist, {super.key});
  final Expense expenselist;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expenselist.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('\$ ${expenselist.amount}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        CategoryIcons[expenselist.category],
                        color: Colors.purple,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(expenselist.formattedDate)
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
