import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  // ================= COLORS =================
  static const Color appBarGray = Colors.grey;
  static const Color expenseColor = Colors.orange;
  static const Color proColor = Colors.blue;
  static const Color statusText = Colors.white;
  static const Color backgroundOverlay = Colors.black45;

  // ================= TEXT =================

  static TextStyle greetingText = GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static TextStyle appBarExpense = GoogleFonts.roboto(
    color: expenseColor,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static TextStyle appBarPro = GoogleFonts.montserrat(
    color: proColor,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static TextStyle sectionTitle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle statusTitle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.white,
  );

  static TextStyle statusHighlight = statusTitle.copyWith(
    color: Colors.lightBlueAccent,
  );

  // ================= EXPENSE CARD =================

  static const TextStyle expenseCategory = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle expenseDate = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  static const TextStyle expenseAmount = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // ================= DECORATIONS =================

  static BoxDecoration selectedCardDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.8),
    borderRadius: BorderRadius.circular(6),
    border: Border.all(color: Colors.grey, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
      ),
    ],
  );

  static BoxDecoration defaultCardDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.8),
    borderRadius: BorderRadius.circular(6),
  );
}
