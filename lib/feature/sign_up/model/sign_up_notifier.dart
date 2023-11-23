import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/sign_up/service/sign_up_service.dart';

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

  final signUpService = SignUpService();

  bool canPress() {
    // TODO: 아이디 중복확인 및 전화번호 인증
    if (_id.error == null &&
        _password.error == null &&
        _reEnterPassword.error == null &&
        _phoneNumber.error == null &&
        _email.error == null) return true;

    return false;
  }

  void changeId(String value) {
    if (value.isEmpty) {
      _id = ValidationItem("", "아이디를 입력해주세요.");
    }

    _id = ValidationItem(value, null);

    canPress();
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.isEmpty) {
      _password = ValidationItem("", "비밀번호를 입력해주세요.");
      _reEnterPassword = ValidationItem("", null);

      notifyListeners();
      canPress();

      return;
    }

    _password = ValidationItem(value, null);

    canPress();
    notifyListeners();
  }

  void changeReEnterPassword(String value) {
    if (value.isEmpty) {
      _reEnterPassword = ValidationItem("", "비밀번호를 한번 더 입력해주세요.");

      canPress();
      notifyListeners();
      return;
    }

    if (value != _password.value) {
      _reEnterPassword = ValidationItem("", "비밀번호가 일치하지 않습니다.");

      canPress();
      notifyListeners();
      return;
    }

    _reEnterPassword = ValidationItem(value, null);

    canPress();
    notifyListeners();
  }

  void changeEmail(String value) {
    if (value.isEmpty) {
      _email = ValidationItem("", "이메일을 입력해주세요.");

      canPress();
      notifyListeners();
      return;
    }

    if (!signUpService.isValidEmailFormat(value)) {
      _email = ValidationItem("", "이메일 주소를 정확히 입력해주세요.");

      canPress();
      notifyListeners();
      return;
    }

    _email = ValidationItem(value, null);

    canPress();
    notifyListeners();
  }

  void changePhoneNumber(String value) {
    if (value.isEmpty) {
      _phoneNumber = ValidationItem("", "휴대폰 번호를 입력해주세요.");

      canPress();
      notifyListeners();
      return;
    }

    _phoneNumber = ValidationItem(value, null);

    canPress();
    notifyListeners();
  }

  bool isEqualPassword() {
    if (password.value != reEnterPassword.value) {
      _reEnterPassword =
          ValidationItem(reEnterPassword.value, "비밀번호가 일치하지 않습니다.");

      canPress();
      notifyListeners();

      return false;
    }

    return true;
  }
}
