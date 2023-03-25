import 'package:easy_localization/easy_localization.dart';
import 'package:grouu/utils/locale/wording_utils.dart';

enum AccountProgression {
  Unverified,
  UncompletedParentInfo,
  UncompletedChildInfo,
  UncompletedChildGrowth,
  UncompletedPreferences,
  Completed,
}

extension AccountProgressionExt on AccountProgression {
  String get title {
    switch (this) {
      case AccountProgression.Unverified:
        return tr("progression_unverified_title");
      case AccountProgression.UncompletedParentInfo:
        return tr("progression_uncompleted_parent_title");
      case AccountProgression.UncompletedChildInfo:
        return tr("progression_uncompleted_child_title");
      case AccountProgression.UncompletedChildGrowth:
        return tr("progression_uncompleted_growth_title");
      case AccountProgression.UncompletedPreferences:
        return tr("progression_uncompleted_preferences_title");
      case AccountProgression.Completed:
        return "";
      default:
        return "";
    }
  }

  String desc(String gender) {
    switch (this) {
      case AccountProgression.Unverified:
        return tr("progression_unverified_subtitle",
            args: [WordingUtils.genderGreeting(gender)]);
      case AccountProgression.UncompletedParentInfo:
        return tr("progression_uncompleted_parent_subtitle",
            args: [WordingUtils.genderGreeting(gender)]);
      case AccountProgression.UncompletedChildInfo:
        return tr("progression_uncompleted_child_subtitle",
            args: [WordingUtils.genderGreeting(gender)]);
      case AccountProgression.UncompletedChildGrowth:
        return tr("progression_uncompleted_growth_subtitle",
            args: [WordingUtils.genderGreeting(gender)]);
      case AccountProgression.UncompletedPreferences:
        return tr("progression_uncompleted_preferences_subtitle",
            args: [WordingUtils.genderGreeting(gender)]);
      case AccountProgression.Completed:
        return "";
      default:
        return "";
    }
  }
}
