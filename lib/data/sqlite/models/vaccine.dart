import 'package:drift/drift.dart';

class Vaccines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get vaccineName => text()();
  TextColumn get vaccineBrands => text().nullable()();
  TextColumn get benefits => text().nullable()();
  TextColumn get indication => text().nullable()();
  TextColumn get contraIndication => text().nullable()();
  TextColumn get sideEffects => text().nullable()();
  TextColumn get howToDeal => text().nullable()();
  IntColumn get vaccinationMonth => integer()();
  TextColumn get imunisasiKejar => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get source => text().nullable()();
}
