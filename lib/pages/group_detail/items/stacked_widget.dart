import 'package:flutter/material.dart';

class StackedWidgets extends StatelessWidget {
  final List<Widget> items;
  final TextDirection direction;
  final double size;
  final double xShift;
  final String label;

  const StackedWidgets({
    Key? key,
    required this.items,
    this.direction = TextDirection.ltr,
    this.size = 100,
    this.xShift = 20,
    this.label = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allItems = items
        .asMap()
        .map((index, item) {
      final left = size - xShift;

      final value = Container(
        width: size,
        height: size,
        margin: EdgeInsets.only(left: left * index),
        child: item,
      );

      return MapEntry(index, value);
    })
        .values
        .toList();

    return Row(
        children: [
          Stack(
            children: direction == TextDirection.ltr
                ? allItems.reversed.toList()
                : allItems,
          ),
          Text(label),
        ]
    );
  }
}