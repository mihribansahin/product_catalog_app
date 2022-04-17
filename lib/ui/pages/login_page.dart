import 'dart:ffi';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_app/providers/auth_provider.dart';
import 'package:product_catalog_app/ui/pages/products_page.dart';
import 'package:product_catalog_app/ui/pages/register_page.dart';
import 'package:product_catalog_app/ui/widgets/custom_button.dart';
import 'package:product_catalog_app/ui/widgets/custom_sizedbox.dart';
import 'package:product_catalog_app/ui/widgets/custom_textfield.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';
import 'package:product_catalog_app/utils/form_validator.dart';
import 'package:product_catalog_app/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../../providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  String? savedPassword, savedUsermail;
  LoginPage({Key? key, this.savedUsermail, this.savedPassword})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? _passwordVisible;
  String? _mailAdress = "", _password = "";
  String? savedUsermail, savedUsername, savedPassword;
  bool? isRememberMe = false;
  String? userToken;
  bool? _value = false;

  final formKey = GlobalKey<FormState>();

  Future getUserInfo() async {
    await UserPreferences.getUserMail().then((value) => savedUsermail = value);
    await UserPreferences.getPassword().then((value) => savedPassword = value);
    await UserPreferences.getRememberMe().then((value) => isRememberMe = value);
    await UserPreferences.getUsername().then((value) => savedUsername = value);
    await UserPreferences.getUserToken().then((value) => userToken = value);
    if (isRememberMe!) {
      setState(() {
        _value = true;
      });
      _emailController.text = savedUsermail ?? "";
      _passwordController.text = savedPassword ?? "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getUserInfo().then((value) => {if (isRememberMe!) {}});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    Future doLogin() async {
      final form = formKey.currentState!;

      if (form.validate()) {
        form.save();
        final Future<Map<String, dynamic>> respose =
            auth.login(_mailAdress!, _password!);

        await respose.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);

            if (user.token!.isEmpty) {
              Flushbar(
                title: "Böyle bir kullanıcı bulunamadı.",
                message: "Lütfen bilgilerinizi kontrol ediniz.",
                backgroundColor: MyColors.errorBorderColor,
                duration: Duration(seconds: 5),
              ).show(context);
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProductPage()));
            }
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: 'Hatalı Giriş',
          message: 'Lütfen bilgilerinizi kontrol ediniz.',
          duration: Duration(seconds: 10),
        ).show(context);
      }

      print('$_mailAdress, $_password ');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
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
                      child: Column(
                        children: [
                          mySizedBox(),
                          loginTextFields(),
                          rememberMeWidget(),
                          mySizedBox(),
                          loginButton(doLogin),
                          createAccontTextButton(context)
                        ],
                      )),
                ),
              ),
              pageTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Container pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 120, left: 30),
      child: const Text(
        "Giriş yap",
        style: TextStyle(
          color: MyColors.myPurple,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
      ),
    );
  }

  Center loginButton(Future doLogin()) {
    return Center(
        child: MyButton(
      buttonText: "Giriş Yap",
      onTapFunc: () {
        //   Future.delayed()
        print("login");
        doLogin();
      },
    ));
  }

  Widget createAccontTextButton(BuildContext context) {
    return InkWell(
      onTap: (() {
        print("register");
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => RegisterPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      }),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(10),
        child: RichText(
          text: const TextSpan(
            text: 'Hesabın yok mu?',
            style: TextStyle(color: Colors.black, fontSize: 12),
            children: <TextSpan>[
              TextSpan(
                  text: ' Kaydol',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: MyColors.myPurple)),
            ],
          ),
        ),
      ),
    );
  }

  Widget rememberMeWidget() {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () async => {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Colors.grey),
                      value: _value,
                      splashRadius: 20,
                      onChanged: (bool? value) {
                        setState(
                          () {
                            _value = !_value!;
                            debugPrint("my value: ${_value}");
                            UserPreferences.setRememberMe(_value!);
                          },
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(1, 0, 2, 0),
                    child: Text(
                      "Beni Hatırla",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginTextFields() {
    return Column(
      children: [
        MyTextFieldWidget(
            myLabel: "E-mail",
            onSubmitted: (val) {},
            controller: _emailController,
            obscureText: false,
            onSaved: (value) => _mailAdress = value,
            textInputType: TextInputType.emailAddress,
            hintText: "example@gmail.com",
            requiredText: "requiredText",
            validator: (val) {
              return validateEmail(_emailController.text);
            }),
        MyTextFieldWidget(
          myLabel: "Password",
          obscureText: !_passwordVisible!,
          onSubmitted: (val) {},
          onSaved: (value) => _password = value,
          controller: _passwordController,
          textInputType: TextInputType.visiblePassword,
          requiredText: "requiredText",
          validator: (val) {
            return validatePassword(_passwordController.text);
          },
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible! ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
              size: 15,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible!;
              });
            },
          ),
        ),
      ],
    );
  }
}
