class BrewSettingsValidator {
  static String nameValidator(String value) {
    if (value.isEmpty) {
      return 'Please, fill with some valid name';
    }

    return null;
  }
}
