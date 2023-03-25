import 'package:flutter/material.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:grouu/models/notification/notification.dart';
import 'package:iconly/iconly.dart';

import '../../constants/font_family.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xFF7ad0e2),
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: ListView.builder(
        itemCount: notificationMockup.length,
        itemBuilder: ((context, index) {
          return NotificationItemWidget(index: index);
        }),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(IconlyLight.arrow_left_2, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text("Notification",
          style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              var snackbar = SnackBar(content: Text("To Be Implemented"));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Mark all as read",
                  style: TextStyle(color: Colors.white)),
            ))
      ],
    );
  }
}

class NotificationItemWidget extends StatelessWidget {
  final int index;
  const NotificationItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          notificationMockup[index].isUnread ? Color(0xFFdef4f8) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNotifIcon(),
              SizedBox(width: 8.0),
              _buildTitle(),
            ],
          ),
          SizedBox(height: 4),
          _buildDate(),
        ]),
      ),
    );
  }

  CircleAvatar _buildNotifIcon() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Color(0xFFeefbfe),
      child: notificationMockup[index].notifType == DataConstants.NOTIF_REMINDER
          ? Image.asset(
              "assets/icons/icon_time.png",
              width: 20,
              height: 20,
            )
          : Image.asset(
              "assets/icons/icon_notification_blue.png",
              width: 20,
              height: 20,
            ),
    );
  }

  Row _buildDate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 48.0),
        Expanded(
          child: Text(
            "${notificationMockup[index].time}",
            textAlign: TextAlign.left,
            maxLines: 2,
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xff676767),
            ),
          ),
        ),
      ],
    );
  }

  Expanded _buildTitle() {
    return Expanded(
      child: Text(
        "${notificationMockup[index].title}",
        textAlign: TextAlign.left,
        maxLines: 2,
        style: TextStyle(
          fontFamily: FontFamily.avenirLTStd,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          height: 1.4,
          color: Color(0xff3E3C3C),
        ),
      ),
    );
  }
}
