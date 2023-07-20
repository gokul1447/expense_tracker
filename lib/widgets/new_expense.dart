import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:expensive_tracker/models/expense.dart';

final formatter = DateFormat.yMd();

class newexpense extends StatefulWidget {
  const newexpense({super.key, required this.onaddexpense});

  final void Function(Expense expense) onaddexpense;

  @override
  State<newexpense> createState() => _newexpenseState();
}

class _newexpenseState extends State<newexpense> {
  final _titlecontrol = TextEditingController();
  final _amountcontrol = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    final selectedamount = double.tryParse(_amountcontrol.text);
    if (_selectedDate == null) {}

    if (selectedamount == null || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_outlined))
          ],
        ),
      );
      return;
    }
    widget.onaddexpense(Expense(
        title: _titlecontrol.text,
        amount: selectedamount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  void _datepicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);
    setState(() {
      _selectedDate = pickeddate;
    });
  }

  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titlecontrol.dispose();
    _amountcontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: [
          TextField(
            controller: _titlecontrol,
            maxLength: 20,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountcontrol,
                      maxLength: 20,
                      decoration: const InputDecoration(label: Text('amount')),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate == null
                            ? 'no date selected'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: _datepicker,
                            icon: const Icon(Icons.calendar_today_outlined))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toString(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
             const Spacer(),
                 TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel',
                    style: TextStyle(color: Color.fromARGB(215, 184, 10, 24))),
                    
              ),
              ElevatedButton(
                  onPressed: () {
                    submitData();
                  },
                  child: const Text("save")),


             
              
            ],
          )
        ],
      ),
    );
  }
}
