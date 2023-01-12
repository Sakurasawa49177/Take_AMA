class ValidateField {
  static String? validateString(String? v) {
    if (v == null || v == "") {
      return "Please fill data";
    }
    return null;
  }

  static String? validateNumber(String? v) {
    if (v == null || v == "") {
      return "Please fill data";
    }
    if (double.tryParse(v) == null) {
      return "invalid number";
    }

    if (double.parse(v) <= 0) {
      return "number must more than 0";
    }
    return null;
  }
}
