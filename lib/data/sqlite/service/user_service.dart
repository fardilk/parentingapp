import 'package:drift/drift.dart';
import 'package:grouu/constants/security.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:xxtea/xxtea.dart';

class UserService {
  final database = getIt<AppDatabase>();

  Future<User> register(String email, String password) async {
    return database.into(database.users).insertReturning(
          UsersCompanion.insert(
            email: email,
            password: xxtea.encryptToString(password, Security.XXTEA_KEY) ?? "",
          ),
        );
  }

  Future<int> updatePassword(int userId, String password) async {
    return (database.update(database.users)..where((t) => t.id.equals(userId)))
        .write(UsersCompanion(
            password: Value(
                xxtea.encryptToString(password, Security.XXTEA_KEY) ?? "")));
  }

  Future<int> updateUser({
    required int id,
    required String email,
    String? firstName,
    String? lastName,
    required String phoneNumber,
    String? gender,
    DateTime? birthday,
    Uint8List? image,
  }) async {
    print(id);
    return (database.update(database.users)..where((t) => t.id.equals(id)))
        .write(UsersCompanion(
      email: Value(email),
      firstName: Value(firstName),
      lastName: Value(lastName),
      phoneNumber: Value(phoneNumber),
      birthday: Value(birthday),
      gender: Value(gender),
      image: Value(image),
    ));
  }

  Future<int> verifyEmail({required int id}) async {
    print(id);
    return (database.update(database.users)..where((t) => t.id.equals(id)))
        .write(UsersCompanion(isVerified: Value(true)));
  }

  Future<int> verifyPhone({required int id}) async {
    print(id);
    return (database.update(database.users)..where((t) => t.id.equals(id)))
        .write(UsersCompanion(isPhoneVerified: Value(true)));
  }

  Future<User> getUser(int id) async {
    return (database.select(database.users)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<int> deleteUser(int id) async {
    return (database.delete(database.users)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<User> login(String email, String password) async {
    return (database.select(database.users)
          ..where((t) =>
              t.email.equals(email) &
              t.password.equals(
                  xxtea.encryptToString(password, Security.XXTEA_KEY) ?? "")))
        .getSingle();
  }

  Future<int> getIdByEmail(String email) async {
    return (database.select(database.users)
          ..where((tbl) => tbl.email.equals(email)))
        .getSingle()
        .then((value) => value.id);
  }
}
