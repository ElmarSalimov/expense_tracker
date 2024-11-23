import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList(
      {super.key, required this.expenseList, required this.removeExpense});

  final List<Expense> expenseList;
  final void Function(Expense expense) removeExpense;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.expenseList.length,
      itemBuilder: (BuildContext context, int index) {
        final Expense expense = widget.expenseList[index];
        return Dismissible(
          key: ValueKey(expense),
          onDismissed: (direction) {
            widget.removeExpense(expense);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            height: 70,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(4)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        expense.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        expense.formattedDate,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${expense.amount}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Icon(
                        categoryIcons[expense.category],
                      ),
                    ],
                  )
                ]),
          ),
        );
      },
    );
  }
}
