import 'package:flutter/services.dart';

// Кастомний formatter для чисел без провідних нулів
class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // Дозволяємо порожній текст
    if (text.isEmpty) return newValue;

    // Регулярний вираз: тільки цифри, необов'язкова одна крапка
    final regExp = RegExp(r'^[0-9]*\.?[0-9]*$');
    if (!regExp.hasMatch(text)) {
      return oldValue; // Якщо не відповідає, повертаємо старий текст
    }

    // Забороняємо провідні нулі (крім "0." для дробів)
    if (text.startsWith('0') && text.length > 1 && !text.startsWith('0.')) {
      return oldValue; // Наприклад, "00" або "005" заборонено
    }

    // Забороняємо кілька крапок
    if ('.'.allMatches(text).length > 1) return oldValue;

    // ✅ НОВЕ: Забороняємо більше 7 цифр після крапки
    if (text.contains('.')) {
      final parts = text.split('.');
      if (parts.length == 2 && parts[1].length > 7) {
        return oldValue; // Наприклад, "1.12345678" заборонено (8 цифр після крапки)
      }
    }

    // ✅ НОВЕ: Забороняємо більше 10 цифр загалом (ігноруючи крапку)
    final digitsOnly = text.replaceAll('.', '');
    if (digitsOnly.length > 10) {
      return oldValue; // Наприклад, "12345678901" заборонено (11 цифр)
    }

    return newValue;
  }
}
