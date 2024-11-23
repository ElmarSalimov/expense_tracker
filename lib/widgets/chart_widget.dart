import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget(
      {super.key,
      required this.totalAmount,
      required this.totalAmountPerCategory});

  final double totalAmount;
  final List<double> totalAmountPerCategory;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight / 4,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChartBar(
                  fill: totalAmountPerCategory[0] / totalAmount,
                ),
                ChartBar(
                  fill: totalAmountPerCategory[1] / totalAmount,
                ),
                ChartBar(
                  fill: totalAmountPerCategory[2] / totalAmount,
                ),
                ChartBar(
                  fill: totalAmountPerCategory[3] / totalAmount,
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(LucideIcons.wheat),
                Icon(LucideIcons.armchair),
                Icon(LucideIcons.backpack),
                Icon(LucideIcons.briefcase),
              ],
            ),
          )
        ],
      ),
    );
  }
}
