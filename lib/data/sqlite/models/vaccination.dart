import 'package:drift/drift.dart';

class Vaccinations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get children => integer()();
  IntColumn get vaccine => integer().nullable()();
  TextColumn get vaccineName => text()();
  IntColumn get vaccinationMonth => integer().nullable()();
  TextColumn get vaccineBrand => text().nullable()();
  TextColumn get locationName => text().nullable()();
  TextColumn get doctorName => text().nullable()();
  TextColumn get batchNumber => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get vaccinationDate => dateTime().nullable()();
  DateTimeColumn get vaccinationSchedule => dateTime().nullable()();
}
