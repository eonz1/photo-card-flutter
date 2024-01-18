import 'package:flutter/material.dart';

import '../../../common/validation/validation_format.dart';
import '../../../common/validation/validation_item.dart';
import '../../../global/logger.dart';

class PasswordEditNotifier with ChangeNotifier {
  ValidationItem _password = ValidationItem("", null);
  ValidationItem _newPassword = ValidationItem("", null);
  ValidationItem _reEnterPassword = ValidationItem("", null);
  bool _canPress = false;

  ValidationItem get password => _password;

  ValidationItem get newPassword => _newPassword;

  ValidationItem get reEnterPassword => _reEnterPassword;

  bool get canPress => _canPress;

  final validationFormat = ValidationFormat();

  void vaildSaveButton() {
    if (password.error != null ||
        newPassword.error != null ||
        reEnterPassword.error != null) {
      _canPress = false;

      return;
    }

    if (password.value == "" ||
        newPassword.value == "" ||
        reEnterPassword.value == "") {
      _canPress = false;

      return;
    }

    _canPress = true;
  }

  void changePassword(String value) {
    if (value.isEmpty) {
      _password = ValidationItem(value, "비밀번호를 입력해주세요.");

      vaildSaveButton();
      notifyListeners();
      return;
    }

    _password = ValidationItem(value, null);

    vaildSaveButton();
    notifyListeners();
  }

  void changeNewPassword(String value) {
    if (value.isEmpty) {
      _newPassword = ValidationItem(value, "새로운 비밀번호를 입력해주세요.");

      vaildSaveButton();
      notifyListeners();
      return;
    }

    if (!validationFormat.isPasswordFormat(value)) {
      _newPassword =
          ValidationItem(value, "영문 대/소문자, 숫자, 특수문자 조합 8-16자이어야 해요.");

      vaildSaveButton();
      notifyListeners();
      return;
    }

    _newPassword = ValidationItem(value, null);

    vaildSaveButton();
    notifyListeners();
  }

  void changeReEnterPassword(String value) {
    if (value.isEmpty) {
      _reEnterPassword = ValidationItem(value, "새로운 비밀번호를 한번 더 입력해주세요.");

      vaildSaveButton();
      notifyListeners();
      return;
    }

    if (value != newPassword.value) {
      _reEnterPassword = ValidationItem(value, "새로운 비밀번호가 일치하지 않습니다.");

      vaildSaveButton();
      notifyListeners();
      return;
    }

    _reEnterPassword = ValidationItem(value, null);

    vaildSaveButton();
    notifyListeners();
  }
}
