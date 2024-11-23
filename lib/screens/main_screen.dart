import 'package:expense_tracker/widgets/chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.setThemeMode});
  final void Function(bool isDarkMode) setThemeMode;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isDarkMode = false;

  List<Expense> expenseList = [
    Expense(
        name: "Georgia Travel",
        amount: 399.99,
        date: DateTime(2022, 2, 2),
        category: Category.travel),
    Expense(
        name: "Cinema",
        amount: 10.99,
        date: DateTime(2022, 2, 2),
        category: Category.leisure)
  ];

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.filterList(expenseList, Category.food),
      ExpenseBucket.filterList(expenseList, Category.leisure),
      ExpenseBucket.filterList(expenseList, Category.travel),
      ExpenseBucket.filterList(expenseList, Category.work),
    ];
  }

  List<double> get totalAmountPerCategory {
    return buckets.map((bucket) => bucket.totalAmount).toList();
  }

  double get totalAmount {
    double sum = 0;
    for (Expense expense in expenseList) {
      sum += expense.amount;
    }

    return sum;
  }

  void addExpense(Expense expense) {
    setState(() {
      expenseList.add(expense);
    });
    Navigator.of(context).pop();
  }

  void removeExpense(Expense expense) {
    final index = expenseList.indexOf(expense);

    setState(() {
      expenseList.remove(expense);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${expense.name} deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                expenseList.insert(index, expense);
              });
            }),
      ));
    });
  }

  void _showDialogueBox() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        context: context,
        builder: (context) {
          return NewExpense(
            addExpense: addExpense,
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          title: const Text(
            "Expense Tracker",
          ),
          centerTitle: true,
          leading: Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                widget.setThemeMode(isDarkMode);
              },
            ),
          ),
          actions: [
            IconButton(
              onPressed: _showDialogueBox,
              icon: const Icon(LucideIcons.plus),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Chart
          ChartWidget(
            totalAmount: totalAmount,
            totalAmountPerCategory: totalAmountPerCategory,
          ),

          expenseList.isNotEmpty
              ? Expanded(
                child: ExpenseList(
                    expenseList: expenseList,
                    removeExpense: removeExpense,
                  ),
              )
              : Center(
                  child: Text(
                    "Add New Expenses...",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
