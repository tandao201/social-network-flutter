import 'package:chat_app_flutter/utils/shared/enums.dart';
import 'package:flutter/material.dart';

class GenderSelectItem extends StatelessWidget {
  final bool isSelected;
  final Gender gender;
  final Function onPressItem;

  const GenderSelectItem({super.key, required this.isSelected, required this.gender, required this.onPressItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressItem(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: isSelected
                ? Colors.indigo.withOpacity(0.3)
                : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: isSelected
                    ? Colors.indigo
                    : Colors.grey.withOpacity(0.5),
                width: 1
            )
        ),
        child: Icon(
          gender.getGenderIcon(),
          color: isSelected
              ? Colors.indigo
              : Colors.blueGrey,
          size: 30,
        ),
      ),
    );
  }
}