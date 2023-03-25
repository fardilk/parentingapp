import 'dart:ui';

enum Resiko { Normal, MediumBelow, MediumAbove, HighBelow, HighAbove, Unknown }

extension ResikoExt on Resiko {
  String get name {
    switch (this) {
      case Resiko.Normal:
        return "Normal";
      case Resiko.MediumBelow:
        return "Resiko Sedang";
      case Resiko.MediumAbove:
        return "Resiko Sedang";
      case Resiko.HighBelow:
        return "Resiko Tinggi";
      case Resiko.HighAbove:
        return "Resiko Tinggi";
      default:
        return "";
    }
  }

  Color get nameColor {
    switch (this) {
      case Resiko.Normal:
        return Color(0xFF25AD0F);
      case Resiko.MediumBelow:
        return Color(0xFFFF9533);
      case Resiko.MediumAbove:
        return Color(0xFFFF9533);
      case Resiko.HighBelow:
        return Color(0xFFDC3434);
      case Resiko.HighAbove:
        return Color(0xFFDC3434);
      default:
        return Color.fromARGB(0, 255, 255, 255);
    }
  }

  Color get backgroundColor {
    switch (this) {
      case Resiko.Normal:
        return Color(0xFFD6FFDA);
      case Resiko.MediumBelow:
        return Color(0xFFFDEBDA);
      case Resiko.MediumAbove:
        return Color(0xFFFDEBDA);
      case Resiko.HighBelow:
        return Color(0xFFFFE7E7);
      case Resiko.HighAbove:
        return Color(0xFFFFE7E7);
      default:
        return Color.fromARGB(0, 255, 255, 255);
    }
  }
}

enum StatsType { Weight, Height, Head, Bmi }

extension StatsTypeExt on StatsType {
  String get typeName {
    switch (this) {
      case StatsType.Head:
        return "Lingkar Kepala";
      case StatsType.Height:
        return "Tinggi Badan";
      case StatsType.Weight:
        return "Berat Badan";
      case StatsType.Bmi:
        return "BMI";
      default:
        return "";
    }
  }

  String get typeSuffix {
    switch (this) {
      case StatsType.Head:
        return "cm";
      case StatsType.Height:
        return "cm";
      case StatsType.Weight:
        return "kg";
      default:
        return "";
    }
  }
}
