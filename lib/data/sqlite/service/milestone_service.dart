import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/data/sqlite/models/milestone.dart';
import 'package:grouu/di/components/service_locator.dart';

class MilestoneService {
  final database = getIt<AppDatabase>();

  Future initMilestone() async {
    var dataMilestone = await allMilestone;
    print(dataMilestone);

    if (dataMilestone.isNotEmpty) {
      return;
    }

    final String response =
        await rootBundle.loadString("assets/json/milestone.json");
    final data = await jsonDecode(response);
    print(data);
    var localMilestone = (data as List).map((e) {
      Map<String, dynamic> json = e;
      return MilestonesCompanion.insert(
        categoryId: json["categoryId"],
        month: json["month"],
        image: Value(json["image"]),
        title: json["title"],
        description: Value(json["description"]),
        stimulation: Value(json["stimulation"]),
        articles: Value(json["articles"]),
      );
    }).toList();
    return database.batch((batch) {
      batch.insertAll(database.milestones, localMilestone);
    });
  }

  Future<List<Milestone>> get allMilestone =>
      database.select(database.milestones).get();

  Future<List<MilestoneChildren>> getUnregisteredMilestone(
      int min, int max) async {
    return database
        .customSelect(
          """SELECT * FROM Milestones LEFT OUTER JOIN Child_Milestones ON Milestones.id = Child_Milestones.milestone
          WHERE Milestones.month BETWEEN $min AND $max;"""
              .trim(),
          readsFrom: {database.milestones, database.childMilestones},
        )
        .watch()
        .map((rows) {
          return rows.map((row) {
            return MilestoneChildren(
                milestone: database.milestones.map(row.data));
          }).toList();
        })
        .first;
  }

  Future<List<MilestoneChildren>> getRegisteredMilestone(
      int childrenId, int min, int max) async {
    return database
        .customSelect(
          """SELECT * FROM Milestones LEFT OUTER JOIN Child_milestones ON Milestones.id = Child_milestones.milestone AND Child_Milestones.children = $childrenId
          WHERE Milestones.month BETWEEN $min AND $max;"""
              .trim(),
          readsFrom: {database.milestones, database.childMilestones},
        )
        .watch()
        .map((rows) {
          return rows.map((row) {
            return MilestoneChildren(
                milestone: database.milestones.map(row.data),
                checked: row.data["children"] == childrenId);
          }).toList();
        })
        .first;
  }

  Future<List<Map<String, dynamic>>> getTotalMilestone(int childrenId) async {
    return database
        .customSelect(
          """SELECT COUNT(id), COUNT(child_milestone_id) FROM Milestones LEFT OUTER JOIN Child_milestones ON Milestones.id = Child_milestones.milestone 
          AND Child_Milestones.children = $childrenId;"""
              .trim(),
          readsFrom: {database.milestones, database.childMilestones},
        )
        .watch()
        .map((rows) {
          return rows.map((row) {
            return {
              "total": row.data["COUNT(id)"],
              "checked": row.data["COUNT(child_milestone_id)"],
            };
          }).toList();
        })
        .first;
  }

  Future<Milestone> getMilestone(int id) async {
    return (database.select(database.milestones)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<ChildMilestone> addMiestone({
    required int childrenId,
    required int milestoneId,
  }) async {
    return database.into(database.childMilestones).insertReturning(
          ChildMilestonesCompanion(
              children: Value(childrenId), milestone: Value(milestoneId)),
        );
  }

  Future<int> deleteMilestone(int id) async {
    return (database.delete(database.milestones)..where((t) => t.id.equals(id)))
        .go();
  }
}
