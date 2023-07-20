import 'package:flutter/material.dart';

import 'package:expensive_tracker/widgets/expenses_list/expense_item.dart';
import 'package:expensive_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,required this.onremoveExpense
  });
  final void Function(Expense expense) onremoveExpense ;

  

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => 
      Dismissible(onDismissed: (direction) {
        onremoveExpense(expenses[index]);
        
      },
        key: ValueKey(expenses[index]), child: ExpenseItem(expenses[index]),)
      
    );
  }
}
