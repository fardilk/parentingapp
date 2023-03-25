import 'package:drift/drift.dart';

class ChildMilestones extends Table {
  IntColumn get childMilestoneId => integer().autoIncrement()();
  IntColumn get milestone => integer()();
  IntColumn get children => integer()();
}
