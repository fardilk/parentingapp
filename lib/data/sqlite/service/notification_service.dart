import 'package:drift/drift.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/models/notification/notification.dart';

import '../../../di/components/service_locator.dart';

class NotificationServices {
  final database = getIt<AppDatabase>();

  Future<NotificationModel> addNotification({
    required int userId,
    required String title,
    required String type,
    required DateTime time,
  }) async {
    return database
        .into(database.notifications)
        .insertReturning(NotificationsCompanion(
          user: Value(userId),
          title: Value(title),
          time: Value(time),
          type: Value(type),
        ));
  }

  Future<void> addAllNotification({
    required int userId,
    required List<NotificationModel> notificationList,
  }) async {
    await database.batch((batch) {
      // functions in a batch don't have to be awaited - just
      // await the whole batch afterwards.
      List<NotificationsCompanion> notifListCompanion = [];

      notificationList.map((e) {
        notifListCompanion.add(NotificationsCompanion(
          user: Value(userId),
          title: Value(e.title),
          time: Value(e.time),
          type: Value(e.type),
        ));
      });
      batch.insertAll(database.notifications, notifListCompanion);
    });
  }
}
