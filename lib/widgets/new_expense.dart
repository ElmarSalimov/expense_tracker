import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  late TextEditingController _titleTextController;
  late TextEditingController _amountTextController;
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void initState() {
    _titleTextController = TextEditingController();
    _amountTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _amountTextController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now, );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountTextController.text);
    final titleValid = _titleTextController.text.trim().isNotEmpty;
    final amountValid = enteredAmount != null && enteredAmount > 0;

    if (titleValid && amountValid && _selectedDate != null) {
      widget.addExpense(Expense(
          name: _titleTextController.text,
          amount: double.tryParse(_amountTextController.text)!,
          date: _selectedDate!,
          category: _selectedCategory));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              'ERROR',
              style: GoogleFonts.lato(
                fontSize: 18,
              ),
            ),
            content: SizedBox(
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!titleValid)
                    Text(
                      "Error: Enter a valid title",
                      style: GoogleFonts.lato(fontSize: 14),
                    ),
                  if (!amountValid)
                    Text(
                      "Error: Enter a valid amount",
                      style: GoogleFonts.lato(fontSize: 14),
                    ),
                  if (_selectedDate == null)
                    Text(
                      "Error: Choose a date",
                      style: GoogleFonts.lato(fontSize: 14),
                    ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).dialogTheme.backgroundColor,
            borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.only(left: 10, top: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                MyTextField(
                  textController: _titleTextController,
                  title: "Title",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date selected"
                          : formatter.format(_selectedDate!),
                      style: GoogleFonts.lato(fontSize: 10),
                    ),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(LucideIcons.calendar),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                MyTextField(
                    textController: _amountTextController,
                    title: "Amount",
                    textInputType: TextInputType.number),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton(
                  style: Theme.of(context).textTheme.bodyMedium,
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.arrow_drop_down),
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.lato(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _submitExpense,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        "Save",
                        style: GoogleFonts.lato(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
