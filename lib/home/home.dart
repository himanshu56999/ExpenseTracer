import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_title.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
@override
void initState(){
  super.initState();
  //prepare the data on setup
Provider.of<ExpenseData>(context,listen: false).prepareData();

}
  //add a new expense

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: "Expense name",
              ),
            ),
            // expense amount
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Expense amount",
              ),
            ),
          ],
        ),
        actions: [

          //save button

          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),


          //cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  //delete expenswe
  void deleteExpense(ExpenseItem expense){
  Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }

  //save
  void save() {
    //create expense item
  if(newExpenseNameController.text.isNotEmpty && newExpenseAmountController.text.isNotEmpty)
    {
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),

      );
      //add new  expense
      Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    }


    Navigator.pop(context);
    clear();
  }

//cancel

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override

  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Expense Tracker'), // Title of your app
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(2),
                  bottomLeft: Radius.circular(2)),
            ),
            elevation: 0.00,
            backgroundColor: Colors.blueGrey[400],
           // Optional: AppBar background color
          ),
        backgroundColor: Colors.grey,
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.add),

        ),
        body: ListView(children: [

          //weekly summary bargraph

ExpenseSummary(startOfWeek: value.startOfWeekDate(),),
          const SizedBox(height: 20,),
          //expense list



          ListView.builder(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTitle(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0)=>deleteExpense( value.getAllExpenseList()[index]),
              ),
          ),
        ],)
      ),
    );
  }
}
