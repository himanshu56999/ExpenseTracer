import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/date_time/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/expense_items.dart';

class ExpenseData extends ChangeNotifier{
  //list of expense
  List<ExpenseItem> overallExpenseList=[];

  //get expense list
List<ExpenseItem> getAllExpenseList(){
return overallExpenseList;
}
final db=HiveDataBase();
//prepare data to display
  void prepareData(){
  //if there exists data prepare data
if(db.readData().isNotEmpty){
  overallExpenseList=db.readData();
}
  }


  // add new expense
void addNewExpense(ExpenseItem newExpense){
  overallExpenseList.add(newExpense);
  notifyListeners();
  db.saveData(overallExpenseList);
}


  //delete expense
void deleteExpense(ExpenseItem expense)
{
  overallExpenseList.remove(expense);
  notifyListeners();
  db.saveData(overallExpenseList);
}


  //get weekdays (mon,tue) from a datetime object
String getDayName (DateTime dateTime)
{
  switch(dateTime.weekday)
      {
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thr";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    case 7:
      return "Sun";
      default:
        return"";
  }
}


  //get the date of the start of the week(sunday)
DateTime startOfWeekDate(){
  DateTime?startOfWeek;

  //get today date
  DateTime today=DateTime.now();

  //go backwards from today to find sunday

  for(int i=0;i<7;i++)
    {
      if(getDayName(today.subtract(Duration(days:i)))=="Sun"){
        startOfWeek=today.subtract(Duration(days: i));
      }
    }
return startOfWeek!;
}


  /* convert overall list of expense into a daily expense summary

  eg overall expense list= [
  [food,10,06,2024, rs10],
  [food,10,06,2024, rs 20],
]


daily expense summary=
[
 [2024,06,10, rs30],
]

   */
Map<String,double>calculateDailyExpenseSummary(){
  Map<String,double>dailyExpenseSummary={
    // day(yyyymmday):amount total for the day


  };

  for(var expense in overallExpenseList){
    String date=convertDateTimeToString(expense.dateTime);
    double amount=double.parse(expense.amount);

    if(dailyExpenseSummary.containsKey(date)){
      double currentAmount=dailyExpenseSummary[date]!;
      currentAmount +=amount;
      dailyExpenseSummary[date]=currentAmount;
    }
    else
      {
        dailyExpenseSummary.addAll({date: amount});
      }
  }
  return dailyExpenseSummary;
}

























}