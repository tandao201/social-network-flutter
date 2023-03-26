import 'package:chat_app_flutter/helper/utilities.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/constants.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  final Color colorPage;
  final String? timeSend;
  final String? avatarImg;

  const MessageTile(
      {Key? key,
        required this.message,
        required this.sender,
        required this.sentByMe,
        required this.colorPage,
        this.timeSend,
        this.avatarImg
      })
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> with WidgetUtils, Utilities {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sentByMe ? 0 : 12,
          right: widget.sentByMe ? 12 : 0),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: widget.sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: widget.sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!widget.sentByMe)
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: widget.colorPage,
                      borderRadius: BorderRadius.circular(40)
                  ),
                  height: 20.w,
                  width: 20.w,
                  child: widget.avatarImg!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: cacheImage(
                              isAvatar: true,
                              imgUrl: widget.avatarImg!
                          ),
                        )
                      : Text(
                          widget.sender.substring(0,1).toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                ),
              Container(
                constraints: BoxConstraints(maxWidth: Constants.widthScreen * 0.6),
                margin: widget.sentByMe
                    ? const EdgeInsets.only(left: 30)
                    : const EdgeInsets.only(right: 30),
                padding:
                const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: widget.sentByMe
                        ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )
                        : const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: widget.sentByMe
                        ? AppColor.messageColor
                        : Colors.grey[700]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.message,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16, color: Colors.white)),

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 1,),
          Padding(
            padding: EdgeInsets.only(left: 20.w+2),
            child: Text(formatDatetimeMiniSecondToHour(widget.timeSend!), style: ThemeTextStyle.body11.copyWith(color: AppColor.grey),),
          )
        ],
      ),
    );
  }
}