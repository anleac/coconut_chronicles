class ValidatorHelper {
  static String? emptyTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  static String? emptyCountryValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a country';
    }
    return null;
  }

  static String? emptyDateValidator(DateTime? value) {
    if (value == null) {
      return 'Please enter a date';
    }
    return null;
  }
}
