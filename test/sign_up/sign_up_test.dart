import 'package:flutter_test/flutter_test.dart';
import 'package:photo_card_flutter/feature/sign_up/service/sign_up_service.dart';

void main() {
  test("이메일 형식 검증 테스트", () {
    final signUpService = SignUpService();

    String email1 = "photocard";
    String email2 = "photocard.photocard";
    String email3 = "photocard@photocard";
    String email4 = "photocard@.photocard";
    String email5 = "photocard@photocard.";
    String email6 = "photocard@photocard.com";

    expect(signUpService.isEmailFormat(email1), false);
    expect(signUpService.isEmailFormat(email2), false);
    expect(signUpService.isEmailFormat(email3), false);
    expect(signUpService.isEmailFormat(email4), false);
    expect(signUpService.isEmailFormat(email5), false);
    expect(signUpService.isEmailFormat(email6), true);
  });
}
