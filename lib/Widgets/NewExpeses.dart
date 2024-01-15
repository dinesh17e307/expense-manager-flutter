import 'package:flutter/material.dart';
import '../Models/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpenses> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpenses> {
  final _titlecontrollers = TextEditingController();
  final _amountcontrollers = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titlecontrollers.dispose();
    _amountcontrollers.dispose();
    super.dispose();
  }

  _submitNewExpense() {
    final enteredAmount = double.tryParse(_amountcontrollers.text);
    final isInValidAmount = enteredAmount == null || enteredAmount <= 0;
    if (_titlecontrollers.text.trim().isEmpty ||
        isInValidAmount ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Details'),
                content: const Text(
                    'Please make sure, you have valid information in amount,title,date,category'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Close'))
                ],
              ));
      return;
    }

    widget.onAddExpense(Expense(
        title: _titlecontrollers.text,
        date: _selectedDate!,
        amount: _amountcontrollers.text,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  _showDatePicker() async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Container(
          child: Column(
            children: [
              TextField(
                maxLength: 50,
                controller: _titlecontrollers,
                decoration: const InputDecoration(
                    label: Text('Title'), focusColor: Colors.purpleAccent),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountcontrollers,
                      decoration: const InputDecoration(
                          prefixText: '\$',
                          label: Text('Amount'),
                          focusColor: Colors.purpleAccent),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate == null
                            ? 'No date Selected'
                            : dateFormatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: _showDatePicker,
                            icon: const Icon(Icons.date_range_outlined))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase())))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('cancel')),
                  ElevatedButton(
                      onPressed: _submitNewExpense,
                      child: const Text('save expense')),
                ],
              )
            ],
          ),
        ));
  }
}
