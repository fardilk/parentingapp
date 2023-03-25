import 'package:drift/drift.dart';

@DataClassName("Children")
class Childrens extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get user => integer()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get gender => text()();
  DateTimeColumn get birthday => dateTime()();
  BlobColumn get image => blob().nullable()();
}
