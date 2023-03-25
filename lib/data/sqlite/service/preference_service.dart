import 'package:drift/drift.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';

class PreferenceService {
  final database = getIt<AppDatabase>();

  Future<Preference> addPreference({
    required int userId,
    bool birthClub = false,
    bool parentsLife = false,
    bool community = false,
    bool pregnancy = false,
    bool fertility = false,
    bool baby = false,
    bool toddler = false,
    bool balita = false,
  }) async {
    return database.into(database.preferences).insertReturning(
        PreferencesCompanion(
            user: Value(userId),
            birthClub: Value(birthClub),
            parentsLife: Value(parentsLife),
            community: Value(community),
            pregnancy: Value(pregnancy),
            fertility: Value(fertility),
            baby: Value(baby),
            toddler: Value(toddler),
            balita: Value(balita)));
  }

  Future<int> updatePreference({
    required int id,
    bool birthClub = false,
    bool parentsLife = false,
    bool community = false,
    bool pregnancy = false,
    bool fertility = false,
    bool baby = false,
    bool toddler = false,
    bool balita = false,
  }) async {
    return (database.update(database.preferences)
          ..where((t) => t.id.equals(id)))
        .write(PreferencesCompanion(
            birthClub: Value(birthClub),
            parentsLife: Value(parentsLife),
            community: Value(community),
            pregnancy: Value(pregnancy),
            fertility: Value(fertility),
            baby: Value(baby),
            toddler: Value(toddler),
            balita: Value(balita)));
  }

  Future<Preference> getPreferenceByUser(int userId) async {
    return (database.select(database.preferences)
          ..where((t) => t.user.equals(userId))
          ..limit(1))
        .getSingle();
  }
}
