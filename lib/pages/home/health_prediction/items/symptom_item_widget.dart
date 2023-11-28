import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class SymptomItem extends StatelessWidget {
  final String text;
  final bool isSelect;
  final Function? onPressed;

  const SymptomItem({Key? key,required this.text,required this.isSelect, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
            color: isSelect ? Colors.blue.withOpacity(0.5) : Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16)
        ),
        child: Text(
          text,
          style: ThemeTextStyle.body14.copyWith(color: isSelect ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}