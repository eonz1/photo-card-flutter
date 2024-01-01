class ValidationFormat {
  bool isEmailFormat(value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  bool isPasswordFormat(value) {
    return RegExp(r"^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$")
        .hasMatch(value);
  }

  bool isIdFormat(value) {
    return RegExp(r"^[a-z0-9]{6,12}$").hasMatch(value);
  }
}
