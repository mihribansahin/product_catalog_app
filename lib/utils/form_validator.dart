 String validateEmail(String value) {
  String  _msg ="";
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Mail adresi zorunlu!";
  } else if (!regex.hasMatch(value)) {
    _msg = "Lütfen geçerli bir e-mail adresi giriniz";
  }
  return _msg;
}
 String validatePassword(String value) {
  String  _msg ="";
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Mail adresi zorunlu!";
  } else if (!regex.hasMatch(value)) {
    _msg = "Lütfen geçerli bir e-mail adresi giriniz";
  }
  return _msg;
}