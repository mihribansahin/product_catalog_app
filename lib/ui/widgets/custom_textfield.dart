import 'package:flutter/material.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';

import '../../utils/form_validator.dart';

class MyTextFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final String? title;
  final String? myLabel;
  final ValueChanged<String>? onChanged;
  TextEditingController controller = TextEditingController();
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final String? errorMessage;
  final String? requiredText;
  Widget? suffixIcon;
  var validator;
  bool obscureText = false;

  MyTextFieldWidget({
    Key? key,
    required this.myLabel,
    required this.onSubmitted,
    this.onChanged,
    required this.controller,
    @required this.title,
    @required this.textInputType,
    @required this.hintText,
    this.focusNode,
    this.errorMessage,
    this.suffixIcon,
    this.validator,
    required this.obscureText,
    @required this.requiredText,
  }) : super(key: key);

  @override
  _MyTextFieldWidgetState createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 60,
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          onChanged: widget.onChanged,
          obscureText: widget.obscureText,

          validator: (val) {
            widget.validator!(val);
          },
          style: const TextStyle(fontFamily: 'Montserrat', fontSize: 13.0),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15.0),
            // Inside box padding
            labelText: widget.myLabel,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,

            // errorText: validateTxt(controller.text),

            hintStyle: const TextStyle(color: MyColors.hintColor),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0.5, color: MyColors.errorBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.5, color: MyColors.enabledBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.5, color: MyColors.outlineInputBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          //textInputAction: TextInputAction.go,
          onFieldSubmitted: widget.onSubmitted,
        ),
      ),
    ]);

    /* validator: (String value) {
            if (value.trim().isEmpty) return requiredText;
          },*/
  }
}
