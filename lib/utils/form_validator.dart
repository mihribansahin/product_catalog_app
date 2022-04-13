import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

String validateEmail(String value) {
  String _msg = "";
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Mail adresi boş geçilemez!";
  } else if (!regex.hasMatch(value)) {
    _msg = "Lütfen geçerli bir e-mail adresi giriniz";
  }
  return _msg;
}

String validatePassword(String value) {
  String _msg = "";

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty) {
    _msg = "Şifre boş geçilemez.";
  }
  if (regExp.hasMatch(value) && (value.length > 6 && value.length < 21)) {
    // true : mihri123!
  } else if (!regExp.hasMatch(value)) {
    //false
    _msg =
        " Şifreniz 6-20 karakterden oluşup en az 1 rakam ve 1 sembol içermelidir.";
  }

  return _msg;
}

String validatePasswordAgain(String password, String passwordAgain) {
  String _msg = "";

  if (password.isEmpty || passwordAgain.isEmpty) {
    _msg = "Şifre alanları boş geçilemez.";
  }
  if ((passwordAgain == password)) {
    // true
  } else {
    //false
    _msg = "Şifrenizi tekrar kontrol ediniz.";
  }

  return _msg;
}
String validatePhoneNumber(String value) {
    String _msg = "";

String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp regExp = new RegExp(patttern);
if (value.length == 0) {
      _msg =  'Lütfen telefon numaranızı giriniz.';
}
else if (!regExp.hasMatch(value)) {
      _msg= 'Geçersiz telefon numarası.';
}
return _msg;
}    

var maskFormatter = MaskTextInputFormatter(
    mask: '+## (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);
