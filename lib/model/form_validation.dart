String? validateContentEmpty(String value, String message) {
  return value.isEmpty ? message : null;
}

String? validateTimeInput(String value, String message) {
  return value.length < 5 ? message : null;
}
