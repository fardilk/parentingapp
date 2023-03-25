import 'package:age_calculator/age_calculator.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:intl/intl.dart';

class WordingUtils {
  static String timeGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) {
      return 'Pagi';
    }
    if (hour >= 11 && hour < 15) {
      return 'Siang';
    }
    if (hour >= 15 && hour < 19) {
      return 'Sore';
    }
    return 'Malam';
  }

  static String genderGreeting(String gender) {
    if (gender == DataConstants.MALE) {
      return 'Paps';
    } else {
      return 'Mams';
    }
  }

  static String getAge(DateTime birthdate) {
    DateDuration duration;
    duration = AgeCalculator.age(birthdate);
    final yearAge = duration.years > 0 ? "${duration.years} Tahun " : "";
    final age = "$yearAge${duration.months} Bulan ${duration.days} Hari";
    return age;
  }

  static String getAgeByTimeDiff(DateTime? birthdate, DateTime date) {
    DateDuration duration;
    duration = AgeCalculator.dateDifference(
        fromDate: birthdate ?? DateTime.now(), toDate: date);
    final yearAge = duration.years > 0 ? "${duration.years} Tahun " : "";
    final age = "$yearAge${duration.months} Bulan ${duration.days} Hari";
    return age;
  }

  static String formatDate(DateTime? value) {
    if (value == null) {
      return " - ";
    } else {
      return DateFormat("d MMM yyyy").format(value);
    }
  }

  static String formatDateString(String? stringDate) {
    try {
      DateTime date = DateTime.parse(stringDate ?? "");
      return formatDate(date);
    } catch (e) {
      print(e);
      return formatDate(DateTime.now());
    }
  }
}
