import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:flutter/material.dart';

import '../../../../models/responses/list_group_response.dart';
import '../../../../utils/shared/enums.dart';

class GroupItem extends StatelessWidget with WidgetUtils {
  final GroupEntity groupEntity;
  final Function onPressed;
  final Function? onPressedJoin;

  const GroupItem({super.key, required this.groupEntity, required this.onPressed, this.onPressedJoin});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(groupEntity.name ?? "", style: ThemeTextStyle.heading14,),
      subtitle: Text(groupEntity.description ?? "", style: ThemeTextStyle.body12.copyWith(color: Colors.grey),),
      leading: CircleAvatar(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: cacheImage(
              imgUrl: groupEntity.banner ?? "",
              isAvatar: false
          ),
        ),
      ),
      trailing: onPressedJoin == null
          ? null
          : buttonAction(
              isJoin: (groupEntity.isJoin ?? 2) != GroupJoinStatus.joined.index,
              onPressed: onPressedJoin
            ),
      onTap: () => onPressed(),
    );
  }

  Widget buttonAction({
    bool isJoin = true,
    Function? onPressed,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onPressed?.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isJoin ? Colors.grey.withOpacity(0.3) : Colors.blue,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Text(
          isJoin ? "Tham gia" : "Đã tham gia",
          style: ThemeTextStyle.body14.copyWith(
            color: isJoin ? Colors.black : Colors.white
          ),
        ),
      ),
    );
  }
}