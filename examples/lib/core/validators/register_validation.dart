class RegisterValidation {
  String? passwordValidation(value) {
    if (value != null && value.isEmpty && value.length < 5) {
      return 'Password is required';
    }
    return null;
  }

  String? nameValidation(value) {
    if (value != null && value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value != null && value.isEmpty) {
      return 'Email is required (eve.holt@reqres.in)';
    } else if (!value.contains('@') || !value.contains('.') || value.length < 5) {
      return 'Email is not valid';
    }
    return null;
  }
}
