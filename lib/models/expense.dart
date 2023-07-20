import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:expensive_tracker/widgets/new_expense.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.expenses,
    required this.category
  }) ;
  ExpenseBucket.forCategory(List<Expense> allexpense , this.category) : expenses = 
  allexpense.where((expense) => expense.category == category).toList() ;
  final Category category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum=0;

  for(final expense in expenses) {
    sum+=expense.amount;

  }
   return sum;
}
  }


 
