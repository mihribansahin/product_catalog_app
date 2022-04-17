import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

String? validateNameSurname(String value) {
  String? _msg;
  if (value.length < 3) {
    return _msg = "Doğru  isim/soyisim giriniz.";
  }
  return null;
}

String? validateEmail(String value) {
  String? _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    return _msg = "Mail adresi boş geçilemez!";
  } else if (!regex.hasMatch(value)) {
    return _msg = "Lütfen geçerli bir e-mail adresi giriniz";
  }
  return null;
}

String? validatePassword(String value) {
  String? _msg;

  String pattern =
      (r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,21}$');

  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty) {
    return _msg = "Şifre boş geçilemez.";
  }
  if (regExp.hasMatch(value)) {
    // true : mihri123!
  } else if (!regExp.hasMatch(value)) {
    //false
    return _msg =
        " Şifreniz 6-20 karakterden oluşup en az 1 rakam ve 1 sembol içermelidir.";
  }

  return null;
}

String? validatePasswordAgain(String password, String passwordAgain) {
  String? _msg;

  if (password.isEmpty || passwordAgain.isEmpty) {
    return _msg = "Şifre alanları boş geçilemez.";
  }
  if ((passwordAgain == password)) {
    // true
  } else {
    //false
    return _msg = "Şifreler aynı olmalıdır.";
  }

  return null;
}

String? validatePhoneNumber(String value) {
  String? _msg;

  String patttern = r'[0-9]';
  RegExp regExp = new RegExp(patttern);
  if (value.length != 19) {
    return _msg = 'Lütfen telefon numaranızı giriniz.';
  } else if (!regExp.hasMatch(value)) {
    return _msg = 'Geçersiz telefon numarası.';
  }
  return null;
}

var maskFormatter = MaskTextInputFormatter(
    mask: '+## (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
    initialText: "asdsaf");
