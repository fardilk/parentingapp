import 'package:drift/drift.dart';
import 'package:grouu/data/sqlite/db/database.dart';

class Milestones extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  IntColumn get month => integer()();
  TextColumn get image => text().nullable()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get stimulation => text().nullable()();
  TextColumn get articles => text().nullable()();
}

class MilestoneChildren {
  MilestoneChildren({required this.milestone, this.checked = false});
  final Milestone milestone;
  final bool checked;
}
