import 'package:drift/drift.dart';

@DataClassName("NotificationModel")
class Notifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get user => integer()();
  TextColumn get title => text()();
  TextColumn get type => text()();
  BoolColumn get isUnread => boolean()();
  DateTimeColumn get time => dateTime()();
}
