const String regexEmail = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

bool isValidEmailAddress(String email) => RegExp(regexEmail).hasMatch(email);

String? emailValidationMessage(String? value) {
  if (value == null || value.trim().isEmpty || !value.contains('@')) {
    return 'Please enter a valid email.';
  }
  if (isValidEmailAddress(value)) return null;
  return 'Please enter a valid email.';
}

String? usernameValidationMessage(String? value) {
  if (value == null || value.isEmpty || value.trim().length < 4) {
    return 'Please enter atleast 4 characters.';
  }
  return null;
}

String? passwordValidationMessage(String? value) {
  if (value == null || value.trim().length < 6) {
    return 'Please enter atleast 6 characters.';
  }
  return null;
}
