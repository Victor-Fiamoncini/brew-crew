import 'package:brew_crew/app/constants/sugars.dart' as constants;

class BrewSettingsValidator {
  static String name(String value) {
    if (value.isEmpty) {
      return 'Please, fill with some valid name';
    }

    return null;
  }

  static String sugars(String value) {
    final hasValidValue = constants.sugars.indexWhere(
      (sugar) => sugar == value,
    );

    if (hasValidValue != -1) {
      return 'Please, fill with some valid sugar value';
    }

    return null;
  }
}
