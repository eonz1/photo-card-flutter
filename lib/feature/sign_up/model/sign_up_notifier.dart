import 'package:flutter/material.dart';

import '../../../common/validation/validation_item.dart';

class SignUpNotifier with ChangeNotifier {
  ValidationItem _id = ValidationItem("", null);
  ValidationItem _password = ValidationItem("", null);
  ValidationItem _reEnterPassword = ValidationItem("", null);
  ValidationItem _phoneNumber = ValidationItem("", null);
  ValidationItem _email = ValidationItem("", null);

  ValidationItem get id => _id;
  ValidationItem get password => _password;
  ValidationItem get reEnterPassword => _reEnterPassword;
  ValidationItem get phoneNumber => _phoneNumber;
  ValidationItem get email => _email;

  void changeId(String value) {
    if (value.isEmpty) {
      _id = ValidationItem("", "아이디를 입력해주세요.");
    }

    _id = ValidationItem(value, null);

    notifyListeners();
  }

  void changePassword(String value) {
    if (value.isEmpty) {
      _password = ValidationItem("", "비밀번호를 입력해주세요.");
      _reEnterPassword = ValidationItem("", null);

      notifyListeners();
      return;
    }

    _password = ValidationItem(value, null);

    notifyListeners();
  }

  void changeReEnterPassword(String value) {
    if (value.isEmpty) {
      _reEnterPassword = ValidationItem("", "비밀번호를 한번 더 입력해주세요.");

      notifyListeners();
      return;
    }

    if (value != _password.value) {
      _reEnterPassword = ValidationItem("", "비밀번호가 일치하지 않습니다.");

      notifyListeners();
      return;
    }

    _reEnterPassword = ValidationItem(value, null);

    notifyListeners();
  }

  void changeEmail(String value) {
    if (value.isEmpty) {
      _email = ValidationItem("", "이메일을 입력해주세요.");

      notifyListeners();
      return;
    }

    if (!_isValidEmailFormat(value)) {
      _email = ValidationItem("", "이메일 주소를 정확히 입력해주세요.");

      notifyListeners();
      return;
    }

    _email = ValidationItem(value, null);

    notifyListeners();
  }

  void changePhoneNumber(String value) {
    if (value.isEmpty) {
      _phoneNumber = ValidationItem("", "휴대폰 번호를 입력해주세요.");

      notifyListeners();
      return;
    }

    _phoneNumber = ValidationItem(value, null);

    notifyListeners();
  }

  bool _isValidEmailFormat(value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  // 맘에 안 듬..
  void isEqualPassword() {
    if (password.value != reEnterPassword.value) {
      _reEnterPassword =
          ValidationItem(reEnterPassword.value, "비밀번호가 일치하지 않습니다.");

      notifyListeners();
    }
  }
}
