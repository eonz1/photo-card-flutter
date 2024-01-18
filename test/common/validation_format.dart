import 'package:flutter_test/flutter_test.dart';
import 'package:photo_card_flutter/common/validation/validation_format.dart';

void main() {
  test("이메일 형식 검증 테스트", () {
    final validationFormat = ValidationFormat();

    String email1 = "photocard";
    String email2 = "photocard.photocard";
    String email3 = "photocard@photocard";
    String email4 = "photocard@.photocard";
    String email5 = "photocard@photocard.";
    String email6 = "photocard@photocard.com";

    expect(validationFormat.isEmailFormat(email1), false);
    expect(validationFormat.isEmailFormat(email2), false);
    expect(validationFormat.isEmailFormat(email3), false);
    expect(validationFormat.isEmailFormat(email4), false);
    expect(validationFormat.isEmailFormat(email5), false);
    expect(validationFormat.isEmailFormat(email6), true);
  });
}
