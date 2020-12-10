import 'package:brew_crew/app/constants/sugars.dart' as constants;

class BrewSettingsValidator {
  static void updateRequest(String name, String sugars, int strength) {
    if (name.isEmpty || sugars.isEmpty || strength == null) {
      throw 'Error to update brew settings, please, try again';
    }

    final hasValidValue = constants.sugars.indexWhere(
      (currentSugars) => currentSugars == sugars,
    );

    if (hasValidValue == -1) {
      throw 'Error to update brew settings, please, try again';
    }
  }
}
