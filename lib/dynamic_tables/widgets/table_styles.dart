import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableStyles {
  static final BorderSide borderSide = BorderSide(color: Colors.grey[300]!);
  static final TableBorder tableBorder = TableBorder(
    top: borderSide,
    bottom: borderSide,
    left: borderSide,
    right: borderSide,
    horizontalInside: borderSide,
    verticalInside: borderSide,
  );

  static final double cellWidth = 40.w;
  static final EdgeInsets headerPadding = EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w);
  static final EdgeInsets cellPadding = EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w);
  static final TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 3.sp);
  static final TextStyle cellTextStyle = TextStyle(fontSize: 3.sp);
}