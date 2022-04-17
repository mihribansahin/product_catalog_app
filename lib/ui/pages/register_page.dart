import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_app/models/user_model.dart';
import 'package:product_catalog_app/providers/auth_provider.dart';
import 'package:product_catalog_app/ui/pages/home_page.dart';
import 'package:product_catalog_app/ui/pages/login_page.dart';
import 'package:product_catalog_app/ui/pages/register_page.dart';
import 'package:product_catalog_app/ui/widgets/custom_button.dart';
import 'package:product_catalog_app/ui/widgets/custom_sizedbox.dart';
import 'package:product_catalog_app/ui/widgets/custom_textfield.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';
import 'package:product_catalog_app/utils/form_validator.dart';
import 'package:product_catalog_app/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? _nameController;
  TextEditingController? _surnameController;
  TextEditingController? _phoneNumberController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _passwordAgainController;

  bool? _passwordVisible;
  bool _value = false;

  String? _name, _surname, _email, _password, _passwordAgain, _phoneNumber;
  final formKey = GlobalKey<FormState>();
UserPreferences userPref = UserPreferences();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();

    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordAgainController = TextEditingController();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    Future doRegister() async {
      //TODO:validate islemleri

      print('on doRegister');

      final form = formKey.currentState;
      print('form!.validate()');
      form!.save();

      print(
          '$_name,$_surname,$_email, $_phoneNumber, $_password, $_passwordAgain, $_phoneNumber');

      // auth.loggedInStatus = Status.Authenticating;

      //auth.notify();

      //  Future.delayed(loginTime).then((_) {
      //    Navigator.pushReplacementNamed(context, '/login');
      //   auth.loggedInStatus = Status.LoggedIn;
      //   auth.notify();
      //  });

      if (_password!.endsWith(_passwordAgain!)) {
        await auth.register(_name!, _email!, _password!).then((response) {

          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
       
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>  LoginPage()));
          } else {
            Flushbar(
              title: 'Kayıt gerçekleşmedi.',
              message: response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: 'Mismatch password',
          message: 'Please enter valid confirm password',
          duration: Duration(seconds: 10),
        ).show(context);
      }
      /*if (form.validate()) {
      } else {
        Flushbar(
          backgroundColor: MyColors.myPurple,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          title: 'Geçersiz form',
          message: 'Lütfen bilgilerinizi kontrol ediniz ',
          duration: Duration(seconds: 10),
        ).show(context);
      }*/
      //  final form = formKey.currentState!.save();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: MyColors.myYellow,
            child: Container(
              margin: const EdgeInsets.only(top: 200),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: Form(
                  key: formKey,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          mySizedBox(),
                          registerTextFields(),
                          registerButton(doRegister),
                          loginAccontTextButton(context)
                        ],
                      ),
                    ),
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 120, left: 30),
            child: const Text(
              "Kayıt ol",
              style: TextStyle(
                color: MyColors.myPurple,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center registerButton( doRegister()) {
    return Center(
        child: MyButton(
      buttonText: "Kayıt ol",
      onTapFunc: () {
        print("register");

        /*Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );*/
        doRegister();
      },
    ));
  }

  Widget loginAccontTextButton(BuildContext context) {
    return InkWell(
      onTap: (() {
        print("register");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  LoginPage()),
        );
      }),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(10),
        child: RichText(
          text: const TextSpan(
            text: 'Hesabın var mı?',
            style: TextStyle(color: Colors.black, fontSize: 12),
            children: <TextSpan>[
              TextSpan(
                  text: ' Giriş Yap',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: MyColors.myPurple)),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerTextFields() {
    return Column(
      children: [
        MyTextFieldWidget(
          myLabel: "Ad",
          onSubmitted: (val) {},
          controller: _nameController!,
          onSaved: (value) => _name = value,
          obscureText: false,
          validator: validateNameSurname(_nameController!.text),
          textInputType: TextInputType.text,
        ),
        MyTextFieldWidget(
          myLabel: "Soyad",
          onSubmitted: (val) {},
          onSaved: (value) => _surname = value,
          controller: _surnameController!,
          obscureText: false,
          validator: validateNameSurname(_surnameController!.text),
          textInputType: TextInputType.text,
        ),
        MyTextFieldWidget(
          myLabel: "Telefon Numarası",
          onSubmitted: (val) {},
          onSaved: (value) => _phoneNumber = value,
          controller: _phoneNumberController!,
          inputFormatters: [maskFormatter],
          hintText: "+xx (xxx) xxx xx xx",
          obscureText: false,
          textInputType: TextInputType.phone,
        ),
        MyTextFieldWidget(
          myLabel: "E-mail",
          onSubmitted: (val) {},
          onSaved: (value) => _email = value,
          controller: _emailController!,
          obscureText: false,
          textInputType: TextInputType.emailAddress,
          hintText: "example@gmail.com",
          validator: validateEmail(_emailController!.text),
        ),
        MyTextFieldWidget(
          myLabel: "Şifre",
          obscureText: true,
          onSaved: (value) => _password = value,
          onSubmitted: (val) {},
          controller: _passwordController!,
          textInputType: TextInputType.visiblePassword,
          validator: validatePassword(_passwordController!.text),
        ),
        MyTextFieldWidget(
          myLabel: "Şifre Tekrar",
          obscureText: true,
          onSubmitted: (val) {},
          onSaved: (value) => _passwordAgain = value,
          controller: _passwordAgainController!,
          textInputType: TextInputType.visiblePassword,
          validator: validatePasswordAgain(
              _passwordController!.text, _passwordAgainController!.text),
        ),
      ],
    );
  }
}
