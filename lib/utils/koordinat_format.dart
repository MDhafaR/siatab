import 'package:flutter/services.dart';

class CoordinateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    int selectionIndex = newValue.selection.end;
    
    // Cari posisi koma
    int commaIndex = text.indexOf(',');
    
    if (commaIndex != -1) {
      // Pastikan ada tepat satu spasi sebelum dan sesudah koma
      String before = text.substring(0, commaIndex).trimRight();
      String after = text.substring(commaIndex + 1).trimLeft();
      String formattedText = '$before , $after';
      
      // Hitung perubahan panjang teks
      int oldLength = text.length;
      int newLength = formattedText.length;
      int diff = newLength - oldLength;
      
      // Sesuaikan posisi kursor
      if (selectionIndex > commaIndex) {
        selectionIndex += diff;
      }
      
      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
    
    // Jika tidak ada koma, kembalikan teks asli
    return newValue;
  }
}