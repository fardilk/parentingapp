import 'package:drift/drift.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';

class ChildrenService {
  final database = getIt<AppDatabase>();

  Future<Children> addChildren({
    required int userId,
    required String firstName,
    required String lastName,
    required String gender,
    required DateTime birthday,
    Uint8List? image,
  }) async {
    return database.into(database.childrens).insertReturning(ChildrensCompanion(
          user: Value(userId),
          firstName: Value(firstName),
          lastName: Value(lastName),
          birthday: Value(birthday),
          gender: Value(gender),
          image: Value(image),
        ));
  }

  Future<int> updateChildren({
    required int id,
    required String firstName,
    required String lastName,
    required String gender,
    required DateTime birthday,
    Uint8List? image,
  }) async {
    return (database.update(database.childrens)..where((t) => t.id.equals(id)))
        .write(ChildrensCompanion(
      firstName: Value(firstName),
      lastName: Value(lastName),
      birthday: Value(birthday),
      gender: Value(gender),
      image: Value(image),
    ));
  }

  Future<Children> getChildren(int id) async {
    return (database.select(database.childrens)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<List<Children>> getChildrensByUser(int userId) async {
    return (database.select(database.childrens)
          ..where((t) => t.user.equals(userId)))
        .get();
  }
}
