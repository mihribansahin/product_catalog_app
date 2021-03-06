import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:product_catalog_app/models/user_model.dart';
import 'package:product_catalog_app/providers/auth_provider.dart';
import 'package:product_catalog_app/ui/pages/login_page.dart';
import 'package:product_catalog_app/ui/pages/products_page.dart';
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

      if (form!.validate()) {
        form.save();

        print(
            '$_name,$_surname,$_email, $_phoneNumber, $_password, $_passwordAgain, $_phoneNumber');

        // auth.loggedInStatus = Status.Authenticating;

        //auth.notify();

        //  Future.delayed(loginTime).then((_) {
        //    Navigator.pushReplacementNamed(context, '/login');
        //   auth.loggedInStatus = Status.LoggedIn;
        //   auth.notify();
        //  });

        await auth.register(_name!, _email!, _password!).then((response) {
          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProductPage()));
          } else {
            Flushbar(
              title: 'Kay??t ger??ekle??medi.',
              message: response.toString(),
              duration: Duration(seconds: 4),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          backgroundColor: MyColors.myPurple,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          title: 'Ge??ersiz form',
          message: 'L??tfen bilgilerinizi kontrol ediniz ',
          duration: Duration(seconds: 10),
        ).show(context);
      }
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
              "Kay??t ol",
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

  Center registerButton(doRegister()) {
    return Center(
        child: MyButton(
      buttonText: "Kay??t ol",
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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => LoginPage(),
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
            text: 'Hesab??n var m???',
            style: TextStyle(color: Colors.black, fontSize: 12),
            children: <TextSpan>[
              TextSpan(
                  text: ' Giri?? Yap',
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
          validator: (val) {
            return validateNameSurname(_nameController!.text);
          },
          textInputType: TextInputType.text,
        ),
        MyTextFieldWidget(
          myLabel: "Soyad",
          onSubmitted: (val) {},
          onSaved: (value) => _surname = value,
          controller: _surnameController!,
          obscureText: false,
          validator: (val) {
            return validateNameSurname(_surnameController!.text);
          },
          textInputType: TextInputType.text,
        ),
        MyTextFieldWidget(
          myLabel: "Telefon Numaras??",
          onSubmitted: (val) {},
          onSaved: (value) => _phoneNumber = value,
          controller: _phoneNumberController!,
          inputFormatters: [maskFormatter],
          hintText: "+xx (xxx) xxx xx xx",
          obscureText: false,
          textInputType: TextInputType.phone,
          validator: (val) {
            return validatePhoneNumber(_phoneNumberController!.text);
          },
        ),
        MyTextFieldWidget(
          myLabel: "E-mail",
          onSubmitted: (val) {},
          onSaved: (value) => _email = value,
          controller: _emailController!,
          obscureText: false,
          textInputType: TextInputType.emailAddress,
          hintText: "example@gmail.com",
          validator: (val) {
            return validateEmail(_emailController!.text);
          },
        ),
        MyTextFieldWidget(
          myLabel: "??ifre",
          obscureText: true,
          onSaved: (value) => _password = value,
          onSubmitted: (val) {},
          controller: _passwordController!,
          textInputType: TextInputType.visiblePassword,
          validator: (val) {
            return validatePassword(_passwordController!.text);
          },
        ),
        MyTextFieldWidget(
            myLabel: "??ifre Tekrar",
            obscureText: true,
            onSubmitted: (val) {},
            onSaved: (value) => _passwordAgain = value,
            controller: _passwordAgainController!,
            textInputType: TextInputType.visiblePassword,
            validator: (val) {
              return validatePasswordAgain(
                  _passwordController!.text, _passwordAgainController!.text);
            }),
      ],
    );
  }
}
