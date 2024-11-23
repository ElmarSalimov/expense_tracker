import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.textController,
      required this.title,
      required this.textInputType});

  final TextEditingController textController;
  final TextInputType textInputType;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: TextField(
        keyboardType: textInputType,
        style: GoogleFonts.lato(
          fontSize: 12,
        ),
        cursorWidth: 2,
        cursorColor: Theme.of(context).colorScheme.onSecondary,
        controller: textController,
        decoration: InputDecoration(
          label: Text(
            title,
            style: GoogleFonts.lato(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary,)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
        ),
      ),
    );
  }
}
