import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';

class VaccineService {
  final database = getIt<AppDatabase>();

  Future initVaccineDetail() async {
    var dataVaccine = await allVaccineDetail;

    if (dataVaccine.isNotEmpty) {
      return;
    }

    final String response =
        await rootBundle.loadString("assets/json/vaccine.json");
    final data = await jsonDecode(response);

    var localVaccine = (data as List).map((e) {
      Map<String, dynamic> json = e;
      return VaccinesCompanion.insert(
        vaccineName: json['vaccineName'],
        vaccineBrands: Value(json['vaccineBrands']),
        benefits: Value(json['benefits']),
        indication: Value(json['indication']),
        contraIndication: Value(json['contraIndication']),
        sideEffects: Value(json['sideEffects']),
        howToDeal: Value(json['howToDeal']),
        vaccinationMonth: json['vaccinationMonth'],
        imunisasiKejar: Value(json['imunisasiKejar']),
        source: Value(json['source']),
        notes: Value(json['notes']),
      );
    }).toList();
    return database.batch((batch) {
      // functions in a batch don't have to be awaited - just
      // await the whole batch afterwards.
      batch.insertAll(database.vaccines, localVaccine);
    });
  }

  Future<List<Vaccine>> get allVaccineDetail =>
      database.select(database.vaccines).get();

  Future<List<Vaccine>> getUnregisteredVaccine(int min, int max) async {
    return (database.select(database.vaccines)
          ..where((a) =>
              a.vaccinationMonth.isBiggerOrEqualValue(min) &
              a.vaccinationMonth.isSmallerOrEqualValue(max)))
        .get();
  }

  Future<List<Vaccine>> searchUnregistered(String query) async {
    return (database.select(database.vaccines)
          ..where((a) =>
              a.benefits.contains(query) |
              a.vaccineName.contains(query) |
              a.vaccineBrands.contains(query) |
              a.indication.contains(query) |
              a.howToDeal.contains(query) |
              a.sideEffects.contains(query)))
        .get();
  }

  Future<List<Vaccination>> searchRegistered(
      String query, int childrenId) async {
    return database
        .customSelect(
          """SELECT * FROM Vaccinations LEFT OUTER JOIN Vaccines ON Vaccinations.vaccine = Vaccines.id AND Vaccinations.children = $childrenId
          WHERE Vaccinations.vaccine_name LIKE '%$query%' 
          OR Vaccines.vaccine_brands LIKE '%$query%' 
          OR Vaccinations.vaccine_brand LIKE '%$query%'
          OR Vaccines.benefits LIKE '%$query%' 
          OR Vaccines.indication LIKE '%$query%' 
          OR Vaccines.side_effects LIKE '%$query%' 
          OR Vaccines.how_to_deal LIKE '%$query%' 
          ;"""
              .trim(),
          readsFrom: {database.vaccines, database.vaccinations},
        )
        .watch()
        .map((rows) {
          return rows.map((row) {
            return Vaccination(
              id: row.data['id'],
              children: row.data['children'],
              vaccineName: row.data['vaccine_name'],
              vaccine: row.data['vaccine'],
              vaccinationMonth: row.data['vaccination_month'],
              locationName: row.data['location_lame'],
              batchNumber: row.data['batch_number'],
              vaccinationDate: row.data['vaccination_date'] == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(
                      row.data['vaccination_date']),
              vaccinationSchedule: row.data['vaccination_schedule'] == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(
                      row.data['vaccination_schedule']),
            );
          }).toList();
        })
        .first;
  }

  Future initChildrenVaccine(int childrenId) async {
    var dataVaccine = await allVaccineDetail;

    if (dataVaccine.isEmpty) {
      return;
    }

    var initialVaccination = dataVaccine.map((e) {
      return VaccinationsCompanion.insert(
          children: childrenId,
          vaccineName: e.vaccineName,
          vaccine: Value(e.id),
          vaccinationMonth: Value(e.vaccinationMonth));
    }).toList();
    return database.batch((batch) {
      batch.insertAll(database.vaccinations, initialVaccination);
    });
  }

  Future<List<Vaccination>> getVaccinationByChildren(
      int childrenId, int min, int max,
      [int? status]) async {
    if (status == 2) {
      return (database.select(database.vaccinations)
            ..where((a) =>
                a.children.equals(childrenId) &
                a.vaccinationMonth.isBiggerOrEqualValue(min) &
                a.vaccinationMonth.isSmallerOrEqualValue(max) &
                a.vaccinationDate.isNotNull()))
          .get();
    }

    if (status == 1) {
      return (database.select(database.vaccinations)
            ..where((a) =>
                a.children.equals(childrenId) &
                a.vaccinationMonth.isBiggerOrEqualValue(min) &
                a.vaccinationMonth.isSmallerOrEqualValue(max) &
                a.vaccinationDate.isNull()))
          .get();
    }

    return (database.select(database.vaccinations)
          ..where((a) =>
              a.children.equals(childrenId) &
              a.vaccinationMonth.isBiggerOrEqualValue(min) &
              a.vaccinationMonth.isSmallerOrEqualValue(max)))
        .get();
  }

  Future<int> updateVaccination(
      {required int id,
      required String vaccineName,
      String? vaccineBrand,
      String? locationName,
      String? doctorName,
      String? batchNumber,
      String? notes,
      DateTime? vaccinationDate,
      DateTime? vaccinationSchedule}) async {
    return (database.update(database.vaccinations)
          ..where((t) => t.id.equals(id)))
        .write(VaccinationsCompanion(
      vaccineName: Value(vaccineName),
      vaccineBrand: Value(vaccineBrand),
      locationName: Value(locationName),
      doctorName: Value(doctorName),
      batchNumber: Value(batchNumber),
      notes: Value(notes),
      vaccinationDate: Value(vaccinationDate),
      vaccinationSchedule: Value(vaccinationSchedule),
    ));
  }

  Future<Vaccine> getVaccine(int id) async {
    return (database.select(database.vaccines)..where((t) => t.id.equals(id)))
        .getSingle();
  }

  Future<Vaccination> addVaccination({
    required int childrenId,
    required String vaccineName,
    required String vaccineBrand,
    required int vaccinationMonth,
    String? locationName,
    String? doctorName,
    String? batchNumber,
    String? notes,
    required DateTime vaccinationDate,
  }) async {
    return database
        .into(database.vaccinations)
        .insertReturning(VaccinationsCompanion(
          children: Value(childrenId),
          vaccineName: Value(vaccineName),
          vaccinationMonth: Value(vaccinationMonth),
          vaccineBrand: Value(vaccineBrand),
          locationName: Value(locationName),
          doctorName: Value(doctorName),
          batchNumber: Value(batchNumber),
          notes: Value(notes),
          vaccinationDate: Value(vaccinationDate),
        ));
  }

  Future<int> deleteVaccination(int id) async {
    return (database.delete(database.vaccinations)
          ..where((t) => t.id.equals(id)))
        .go();
  }
}
