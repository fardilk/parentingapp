import 'dart:io';

import 'package:drift/drift.dart';
import 'package:grouu/data/sqlite/models/child_milestones.dart';
import 'package:grouu/data/sqlite/models/childrens.dart';
import 'package:grouu/data/sqlite/models/growths.dart';
import 'package:grouu/data/sqlite/models/milestone.dart';
import 'package:grouu/data/sqlite/models/notifications.dart';
import 'package:grouu/data/sqlite/models/preferences.dart';
import 'package:grouu/data/sqlite/models/users.dart';
import 'package:grouu/data/sqlite/models/vaccination.dart';
import 'package:grouu/data/sqlite/models/vaccine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Users,
  Childrens,
  Preferences,
  Growths,
  Notifications,
  Vaccinations,
  Vaccines,
  Milestones,
  ChildMilestones
])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 3) {
          await m.createTable(vaccinations);
          await m.createTable(vaccines);
        }
        if (from < 4) {
          await m.createTable(milestones);
          await m.createTable(childMilestones);
        }
        if (from < 5) {
          await m.addColumn(users, users.isVerified);
        }
        if (from < 6) {
          await m.addColumn(users, users.isPhoneVerified);
        }
        if (from < 7) {
          await m.addColumn(vaccines, vaccines.source);
          await m.addColumn(vaccines, vaccines.imunisasiKejar);
          await m.addColumn(vaccines, vaccines.notes);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
