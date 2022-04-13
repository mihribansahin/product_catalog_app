import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';

class MyButton extends StatelessWidget {
  Function()? onTapFunc = () {};
  String buttonText = "";

  MyButton({Key? key, required this.onTapFunc, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7.0,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: InkWell(
        onTap: onTapFunc,
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              MyColors.myYellow,
              MyColors.myPink,
              MyColors.myPurple,
            ]),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          height: 40,
          width: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
