import 'package:drift/drift.dart';

@DataClassName("Growth")
class Growths extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get user => integer()();
  IntColumn get children => integer()();
  RealColumn get height => real()();
  RealColumn get weight => real()();
  RealColumn get headCircumference => real()();
  DateTimeColumn get measurementDate =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
