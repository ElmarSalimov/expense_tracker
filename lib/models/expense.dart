import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { leisure, food, travel, work }

const categoryIcons = {
  Category.leisure: LucideIcons.armchair,
  Category.food: LucideIcons.wheat,
  Category.travel: LucideIcons.backpack,
  Category.work: LucideIcons.briefcase
};

class Expense {
  Expense(
      {required this.name,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final List<Expense> expenses;
  final Category category;

  ExpenseBucket.filterList(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where(
              (element) => element.category == category,
            )
            .toList();

  double get totalAmount {
    double sum = 0;

    for (Expense expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
