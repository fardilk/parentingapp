import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/models/growth/local_growth.dart';

class GrowthService {
  final database = getIt<AppDatabase>();

  Future<Growth> addGrowth({
    required int userId,
    required int childrenId,
    required double height,
    required double weight,
    required double headCircumference,
    required DateTime measurementDate,
  }) async {
    return database.into(database.growths).insertReturning(
          GrowthsCompanion(
            user: Value(userId),
            children: Value(childrenId),
            height: Value(height),
            weight: Value(weight),
            headCircumference: Value(headCircumference),
            measurementDate: Value(measurementDate),
          ),
        );
  }

  Future<int> updateGrowth({
    required int id,
    required double height,
    required double weight,
    required double headCircumference,
    required DateTime measurementDate,
  }) async {
    return (database.update(database.growths)..where((t) => t.id.equals(id)))
        .write(GrowthsCompanion(
      height: Value(height),
      weight: Value(weight),
      headCircumference: Value(headCircumference),
      measurementDate: Value(measurementDate),
    ));
  }

  Future<int> deleteGrowth({
    required int id,
  }) async {
    return (database.delete(database.growths)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<Growth> getGrowth(int id) async {
    return (database.select(database.growths)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<List<Growth>> getGrowthsByUser(int userId) async {
    final query = database.select(database.growths);
    query.where((t) => t.user.equals(userId));
    query.orderBy([
      (t) =>
          OrderingTerm(expression: t.measurementDate, mode: OrderingMode.desc)
    ]);
    return query.get();
  }

  Future<List<LocalGrowth>> getGrowthJson(String assetPath) async {
    final String response = await rootBundle.loadString(assetPath);
    final data = await jsonDecode(response);

    var localGrowth =
        (data as List).map((e) => LocalGrowth.fromJson(e)).toList();
    return localGrowth;
  }
}
