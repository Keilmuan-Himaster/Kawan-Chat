import 'package:flutter/material.dart';

BoxShadow customBoxShadow(
    {double? spreadRadius, double? blurRadius, Offset? offset, Color? color}) {
  return BoxShadow(
    color: (color == null) ? Colors.grey.withOpacity(0.1) : color,
    spreadRadius: (spreadRadius == null) ? 5 : spreadRadius,
    blurRadius: (blurRadius == null) ? 7 : blurRadius,
    offset: (offset == null) ? Offset(0, 0) : offset,
  );
}