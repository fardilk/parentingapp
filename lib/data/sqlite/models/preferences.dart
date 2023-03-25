import 'package:drift/drift.dart';

class Preferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get user => integer()();
  BoolColumn get birthClub => boolean().withDefault(const Constant(false))();
  BoolColumn get parentsLife => boolean().withDefault(const Constant(false))();
  BoolColumn get community => boolean().withDefault(const Constant(false))();
  BoolColumn get pregnancy => boolean().withDefault(const Constant(false))();
  BoolColumn get fertility => boolean().withDefault(const Constant(false))();
  BoolColumn get baby => boolean().withDefault(const Constant(false))();
  BoolColumn get toddler => boolean().withDefault(const Constant(false))();
  BoolColumn get balita => boolean().withDefault(const Constant(false))();
}
