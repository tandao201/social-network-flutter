import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle color(Color color) => copyWith(color: color);
}