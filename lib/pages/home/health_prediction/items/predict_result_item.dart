import 'package:chat_app_flutter/utils/shared/utilities.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:flutter/material.dart';

import '../../../../models/health_prediction/diagnosis_entity.dart';

class PredictResultItem extends StatelessWidget with WidgetUtils {
  final DiagnosisEntity predictEntity;
  final Function? onPressed;

  const PredictResultItem({Key? key, required this.predictEntity, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  predictEntity.Issue?.Name ?? "",
                  style: ThemeTextStyle.heading14.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Độ chính xác: ${predictEntity.Issue?.Accuracy?.toInt()}%",
                  style: ThemeTextStyle.body14.copyWith(
                      color: Utilities.getColorAccuracy(predictEntity.Issue?.Accuracy?.toInt() ?? 0),
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Divider(height: 1, color: Colors.grey.withOpacity(0.5),),
            ),
            contentText(
              title: "Mã phân loại bệnh: ",
              content: predictEntity.Issue?.Icd ?? ""
            ),
            contentText(
                title: "Tên phân loại bệnh: ",
                content: predictEntity.Issue?.IcdName ?? ""
            ),
          ],
        ),
      ),
    );
  }
}