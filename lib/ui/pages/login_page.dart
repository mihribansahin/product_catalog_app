import 'package:flutter/material.dart';
import 'package:product_catalog_app/ui/pages/register_page.dart';
import 'package:product_catalog_app/ui/widgets/custom_button.dart';
import 'package:product_catalog_app/ui/widgets/custom_sizedbox.dart';
import 'package:product_catalog_app/ui/widgets/custom_textfield.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';
import 'package:product_catalog_app/utils/form_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  bool? _passwordVisible;
  bool _value = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                    child: Column(
                  children: [
                    mySizedBox(),
                    loginTextFields(),
                    rememberMeWidget(),
                    mySizedBox(),
                    loginButton(),
                    createAccontTextButton(context)
                  ],
                )),
              ),
            ),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget createAccontTextButton(BuildContext context) {
    return InkWell(
      onTap: (() {
        print("register");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      }),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(20),
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

  doLogin() {
     //TODO:validate islemleri


  }
  Widget loginButton() {
    return Center(
        child: MyButton(
      buttonText: "Giriş Yap",
      onTapFunc: () {
        print("login");
        doLogin();
      },
    ));
  }

  Widget rememberMeWidget() {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () => {
          debugPrint("Remember me on clicked."),
          _value = !_value,
          debugPrint("checkbox value = $_value")
        },
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
                            _value = !_value;
                            debugPrint("my value: ${_value}");
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
          controller: _emailController!,
          obscureText: false,
          textInputType: TextInputType.emailAddress,
          hintText: "example@gmail.com",
          requiredText: "requiredText",
          validator: validateEmail(_emailController!.text),
        ),
        MyTextFieldWidget(
          myLabel: "Password",
          obscureText: !_passwordVisible!,
          onSubmitted: (val) {},
          controller: _passwordController!,
          textInputType: TextInputType.visiblePassword,
          requiredText: "requiredText",
          validator: validatePassword(_passwordController!.text),
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
