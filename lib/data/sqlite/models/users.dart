import 'package:drift/drift.dart';

@DataClassName("User")
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get gender => text().nullable()();
  BlobColumn get image => blob().nullable()();
  DateTimeColumn get birthday => dateTime().nullable()();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  BoolColumn get isPhoneVerified => boolean().withDefault(const Constant(false))();
}
