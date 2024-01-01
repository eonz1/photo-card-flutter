import 'package:flutter/material.dart';
import 'package:photo_card_flutter/feature/sign_up/service/sign_up_service.dart';

import '../../../common/validation/validation_item.dart';

class SignUpNotifier with ChangeNotifier {
  ValidationItem _id = ValidationItem("", null);
  ValidationItem _password = ValidationItem("", null);
  ValidationItem _reEnterPassword = ValidationItem("", null);
  ValidationItem _phoneNumber = ValidationItem("", null);
  ValidationItem _email = ValidationItem("", null);
  bool _canPress = false;
  bool _didEmailVerify = false;

  ValidationItem get id => _id;

  ValidationItem get password => _password;

  ValidationItem get reEnterPassword => _reEnterPassword;

  ValidationItem get phoneNumber => _phoneNumber;

  ValidationItem get email => _email;

  bool get canPress => _canPress;

  bool get didEmailVerify => _didEmailVerify;

  final signUpService = SignUpService();

  void vaildSignUpButton() {
    // TODO: 아이디 중복 확인 했는 지

    if (id.error != null ||
        password.error != null ||
        reEnterPassword.error != null ||
        phoneNumber.error != null ||
        email.error != null ||
        didEmailVerify != true) {
      _canPress = false;

      notifyListeners();
      return;
    }

    if (id.value == "" ||
        password.value == "" ||
        reEnterPassword.value == "" ||
        phoneNumber.value == "" ||
        email.value == "" ||
        didEmailVerify != true) {
      _canPress = false;

      notifyListeners();
      return;
    }

    _canPress = true;
    notifyListeners();
  }

  void changeId(String value) {
    if (value.isEmpty) {
      _id = ValidationItem("", "아이디를 입력해주세요.");

      notifyListeners();
      vaildSignUpButton();
      return;
    }

    if (!signUpService.isIdFormat(value)) {
      _id = ValidationItem(value, "영문 소문자와 숫자 조합 6-12자이어야 해요.");

      vaildSignUpButton();
      notifyListeners();
      return;
    }

    _id = ValidationItem(value, null);

    vaildSignUpButton();
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.isEmpty) {
      _password = ValidationItem("", "비밀번호를 입력해주세요.");
      _reEnterPassword = ValidationItem("", null);

      notifyListeners();
      vaildSignUpButton();
      return;
    }

    if (!signUpService.isPasswordFormat(value)) {
      _password = ValidationItem(value, "영문 대/소문자, 숫자, 특수문자 조합 8-16자이어야 해요.");
      _reEnterPassword = ValidationItem("", null);

      vaildSignUpButton();
      notifyListeners();
      return;
    }

    _password = ValidationItem(value, null);

    vaildSignUpButton();
    notifyListeners();
  }

  void changeReEnterPassword(String value) {
    if (value.isEmpty) {
      _reEnterPassword = ValidationItem("", "비밀번호를 한번 더 입력해주세요.");

      vaildSignUpButton();
      notifyListeners();
      return;
    }

    if (value != password.value) {
      _reEnterPassword = ValidationItem("", "비밀번호가 일치하지 않습니다.");

      vaildSignUpButton();
      notifyListeners();
      return;
    }

    _reEnterPassword = ValidationItem(value, null);

    vaildSignUpButton();
    notifyListeners();
  }

  void changeEmail(String value) {
    if (value.isEmpty) {
      _email = ValidationItem("", "이메일을 입력해주세요.");

      vaildSignUpButton();
      notifyListeners();
      return;
    }

    if (!signUpService.isEmailFormat(value)) {
      _email = ValidationItem("", "이메일 주소를 정확히 입력해주세요.");

      vaildSignUpButton();
      notifyListeners();
      return;
    }

    _email = ValidationItem(value, null);

    vaildSignUpButton();
    notifyListeners();
  }

  void changePhoneNumber(String value) {
    if (value.isEmpty) {
      _phoneNumber = ValidationItem("", "휴대폰 번호를 입력해주세요.");

      vaildSignUpButton();
      notifyListeners();
      return;
    }

    _phoneNumber = ValidationItem(value, null);

    vaildSignUpButton();
    notifyListeners();
  }

  bool isEqualPassword() {
    if (password.value != reEnterPassword.value) {
      _reEnterPassword =
          ValidationItem(reEnterPassword.value, "비밀번호가 일치하지 않습니다.");

      vaildSignUpButton();
      notifyListeners();

      return false;
    }

    return true;
  }

  void isDuplicatedId(bool value) {
    if (value == true) {
      _id = ValidationItem(id.value, "이미 사용 중인 아이디입니다.");
    } else {
      _id = ValidationItem(id.value, null);
    }

    notifyListeners();
  }

  void isEmailVerify(bool value) {
    _didEmailVerify = value;

    notifyListeners();
  }
}
