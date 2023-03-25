import 'package:grouu/data/sqlite/db/database.dart';

class Periode {
  const Periode({
    required this.periodeId,
    required this.periodeTitle,
    required this.min,
    required this.max,
  });
  final int periodeId;
  final String periodeTitle;
  final int min;
  final int max;
}

class VaccineSchedule {
  const VaccineSchedule({
    required this.scheduleId,
    required this.shceduleTitle,
    required this.listVaccine,
    this.listVaccination,
  });
  final int scheduleId;
  final String shceduleTitle;
  final List<Vaccine> listVaccine;
  final List<Vaccination>? listVaccination;
}

class DataPeriode {
  DataPeriode._();

  static List<Periode> listPeriode = [
    Periode(
      periodeId: 0,
      periodeTitle: "0-3 bulan",
      min: 0,
      max: 3,
    ),
    Periode(
      periodeId: 1,
      periodeTitle: "3-6 bulan",
      min: 3,
      max: 6,
    ),
    Periode(
      periodeId: 2,
      periodeTitle: "6-9 bulan",
      min: 6,
      max: 9,
    ),
    Periode(
      periodeId: 3,
      periodeTitle: "9-12 bulan",
      min: 9,
      max: 12,
    ),
    Periode(
      periodeId: 4,
      periodeTitle: "1-3 tahun",
      min: 12,
      max: 36,
    ),
    Periode(
      periodeId: 5,
      periodeTitle: "3-6 tahun",
      min: 36,
      max: 72,
    ),
    Periode(
      periodeId: 6,
      periodeTitle: "6-9 tahun",
      min: 72,
      max: 108,
    ),
    Periode(
      periodeId: 7,
      periodeTitle: "9-12 tahun",
      min: 108,
      max: 144,
    ),
    Periode(
      periodeId: 8,
      periodeTitle: "12-18 tahun",
      min: 144,
      max: 216,
    ),
  ];

  static List<Periode> listMilestonePeriode = [
    Periode(
      periodeId: 0,
      periodeTitle: "0-2 bulan",
      min: 0,
      max: 2,
    ),
    Periode(
      periodeId: 1,
      periodeTitle: "2-4 bulan",
      min: 2,
      max: 4,
    ),
    Periode(
      periodeId: 2,
      periodeTitle: "4-6 bulan",
      min: 4,
      max: 6,
    ),
    Periode(
      periodeId: 3,
      periodeTitle: "6-9 bulan",
      min: 6,
      max: 9,
    ),
    Periode(
      periodeId: 4,
      periodeTitle: "9-12 bulan",
      min: 9,
      max: 12,
    ),
    Periode(
      periodeId: 5,
      periodeTitle: "12-18 bulan",
      min: 12,
      max: 18,
    ),
    Periode(
      periodeId: 6,
      periodeTitle: "18 bulan - 2 tahun",
      min: 18,
      max: 24,
    ),
    Periode(
      periodeId: 7,
      periodeTitle: "2-3 tahun",
      min: 24,
      max: 36,
    ),
    Periode(
      periodeId: 8,
      periodeTitle: "3-4 tahun",
      min: 36,
      max: 48,
    ),
    Periode(
      periodeId: 9,
      periodeTitle: "4-6 tahun",
      min: 48,
      max: 72,
    ),
  ];
}
