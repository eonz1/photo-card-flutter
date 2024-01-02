import 'package:flutter/material.dart';

import '../../../common/validation/validation_format.dart';
import '../../../common/validation/validation_item.dart';

class PasswordEditNotifier with ChangeNotifier {
  ValidationItem _password = ValidationItem("", null);
  ValidationItem _newPassword = ValidationItem("", null);
  ValidationItem _reEnterPassword = ValidationItem("", null);

  ValidationItem get password => _password;
  ValidationItem get newPassword => _newPassword;
  ValidationItem get reEnterPassword => _reEnterPassword;

  final validationFormat = ValidationFormat();

  void changePassword(String value) {
    if (value.isEmpty) {
      _password = ValidationItem("", "비밀번호를 입력해주세요.");

      notifyListeners();
      return;
    }

    _password = ValidationItem(value, null);

    notifyListeners();
  }

  void changeNewPassword(String value) {
    if (value.isEmpty) {
      _newPassword = ValidationItem("", "새로운 비밀번호를 입력해주세요.");
      _reEnterPassword = ValidationItem("", null);

      notifyListeners();
      return;
    }

    if (!validationFormat.isPasswordFormat(value)) {
      _newPassword =
          ValidationItem(value, "영문 대/소문자, 숫자, 특수문자 조합 8-16자이어야 해요.");
      _reEnterPassword = ValidationItem("", null);

      notifyListeners();
      return;
    }

    _newPassword = ValidationItem(value, null);

    notifyListeners();
  }

  void changeReEnterPassword(String value) {
    if (value.isEmpty) {
      _reEnterPassword = ValidationItem("", "새로운 비밀번호를 한번 더 입력해주세요.");

      notifyListeners();
      return;
    }

    if (value != password.value) {
      _reEnterPassword = ValidationItem("", "새로운 비밀번호가 일치하지 않습니다.");

      notifyListeners();
      return;
    }

    _reEnterPassword = ValidationItem(value, null);

    notifyListeners();
  }
}
