import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const CategoryIcons = {
  Category.food: Icons.dining_outlined,
  Category.leisure: Icons.bluetooth,
  Category.work: Icons.work,
  Category.travel: Icons.travel_explore
};

class Expense {
  Expense(
      {required this.title,
      required this.date,
      required this.amount,
      required this.category})
      : id = const Uuid().v4();
  final String id;
  final String title;
  final String amount;
  final DateTime date;
  final Category category;
  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;
  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += double.parse(expense.amount);
    }
    return sum;
  }
}
