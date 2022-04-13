import 'package:flutter/material.dart';
import 'package:product_catalog_app/ui/pages/login_page.dart';
import 'package:product_catalog_app/ui/pages/register_page.dart';
import 'package:product_catalog_app/ui/widgets/custom_button.dart';
import 'package:product_catalog_app/ui/widgets/custom_sizedbox.dart';
import 'package:product_catalog_app/ui/widgets/custom_textfield.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';
import 'package:product_catalog_app/utils/form_validator.dart';

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
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    mySizedBox(),
                    registerTextFields(),
                    registerButton(),
                    loginAccontTextButton(context)
                  ],
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

  Widget loginAccontTextButton(BuildContext context) {
    return InkWell(
      onTap: (() {
        print("register");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
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

  doRegister() {
    //TODO:validate islemleri
  }
  Widget registerButton() {
    return Center(
        child: MyButton(
      buttonText: "Kayıt ol",
      onTapFunc: () {
        print("register");
        doRegister();
      },
    ));
  }

  Widget registerTextFields() {
    return Column(
      children: [
        MyTextFieldWidget(
          myLabel: "Ad",
          onSubmitted: (val) {},
          controller: _nameController!,
          obscureText: false,
          textInputType: TextInputType.text,
        ),
        MyTextFieldWidget(
          myLabel: "Soyad",
          onSubmitted: (val) {},
          controller: _surnameController!,
          obscureText: false,
          textInputType: TextInputType.text,
        ),
        MyTextFieldWidget(
          myLabel: "Telefon Numarası",
          onSubmitted: (val) {},
          controller: _phoneNumberController!,
          inputFormatters: [maskFormatter],
          hintText: "+xx (xxx) xxx xx xx",
          obscureText: false,
          textInputType: TextInputType.phone,
          validator: validatePhoneNumber(_phoneNumberController!.text),
        ),
        MyTextFieldWidget(
          myLabel: "E-mail",
          onSubmitted: (val) {},
          controller: _emailController!,
          obscureText: false,
          textInputType: TextInputType.emailAddress,
          hintText: "example@gmail.com",
          validator: validateEmail(_emailController!.text),
        ),
        MyTextFieldWidget(
          myLabel: "Şifre",
          obscureText: true,
          onSubmitted: (val) {},
          controller: _passwordController!,
          textInputType: TextInputType.visiblePassword,
          validator: validatePassword(_passwordController!.text),
        ),
        MyTextFieldWidget(
          myLabel: "Şifre Tekrar",
          obscureText: true,
          onSubmitted: (val) {},
          controller: _passwordAgainController!,
          textInputType: TextInputType.visiblePassword,
          validator: validatePasswordAgain(
              _passwordController!.text, _passwordAgainController!.text),
        ),
      ],
    );
  }
}
