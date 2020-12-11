class BrewSettingsValidator {
  static void updateRequest(String name, String sugars, int strength) {
    if (name.isEmpty || sugars.isEmpty || (strength < 100 && strength > 900)) {
      throw 'Error to update brew settings, please, try again';
    }
  }
}
