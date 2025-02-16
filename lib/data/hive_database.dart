import 'dart:math';

import 'package:hive/hive.dart';

import '../models/expense_items.dart';

class HiveDataBase{
  //reference our box
  final _myBox= Hive.box("expense_database");

  //writing data
void saveData(List<ExpenseItem>allExpense){

  /*
  hive can only store string and date time

   */
  List<List<dynamic>>allExpensesFormatted=[];
  for(var expense in allExpense)
    {
      List<dynamic>expenseFormatted=[
      expense.name,
      expense.amount,
      expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);

    }
  _myBox.put("ALL_EXPENSES",allExpensesFormatted);

}
  //reading data

  List<ExpenseItem>readData(){

    List savedExpenses=_myBox.get("ALL_EXPENSES")??[];

    List<ExpenseItem>allExpenses=[];

    for(int i=0;i<savedExpenses.length;i++)
      {
        String name=savedExpenses[i][0];
        String amount=savedExpenses[i][1];
        DateTime dateTime=savedExpenses[i][2];
        
        //create expense item
        ExpenseItem expense= ExpenseItem(name: name, amount: amount, dateTime: dateTime,);
        allExpenses.add(expense);
      }

    return allExpenses;
  }

}
