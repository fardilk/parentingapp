import 'package:grouu/data/local/constants/data_constants.dart';

class NotificationLocalModel {
  final String notifType;
  final String title;
  final String time;
  final bool isUnread;

  NotificationLocalModel({
    required this.notifType,
    required this.title,
    required this.time,
    required this.isUnread,
  });
}

List<NotificationLocalModel> notificationMockup = [
  NotificationLocalModel(
    notifType: DataConstants.NOTIF_REMINDER,
    title: 'Jangan lupa untuk track perkembangan anak kamu',
    time: '19 November 2022 10:22',
    isUnread: false,
  ),
  NotificationLocalModel(
    notifType: DataConstants.NOTIF_NOTIFICATION,
    title:
        'Grouu telah melakukan update aplikasi ke versi 0.12. Update sekarang!',
    time: '19 November 2022 10:22',
    isUnread: true,
  ),
  NotificationLocalModel(
    notifType: DataConstants.NOTIF_REMINDER,
    title: 'Waktunya vaksin nih, jangan lupa input data vaksin ya mam',
    time: '19 November 2022 10:22',
    isUnread: false,
  ),
  NotificationLocalModel(
    notifType: DataConstants.NOTIF_REMINDER,
    title:
        'Jangan lupa untuk vaksin sikecil nanti di tanggal 16 November 2022 ya mam',
    time: '19 November 2022 10:22',
    isUnread: false,
  ),
];
