import 'package:flutter/material.dart';
import 'package:ecommerece/constants.dart';

import 'CustomText.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final String headerText;
  final String hint;
  TextEditingController? textEditingController;
  VoidCallback? onEditComplete;
  FocusNode? focusNode;
  bool isError;

  CustomTextField(
      {super.key,
      this.isPassword = false,
      required this.headerText,
      required this.hint,
      this.onEditComplete,
      this.focusNode,
      this.textEditingController,
      this.isError = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: widget.headerText,
          size: 16,
          color: widget.isError ? Colors.red : TextFieldColor,
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
            cursorColor: TextFieldColor,
            obscureText: widget.isPassword,
            autocorrect: !widget.isPassword,
            keyboardType: widget.isPassword
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color: widget.isError?Colors.red:TextFieldColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: TextFieldColor),
                )),
            onEditingComplete: widget.onEditComplete,
            focusNode: widget.focusNode,
            controller: widget.textEditingController,
            onTapOutside: ((event) {
              FocusScope.of(context).unfocus();
            }),
            onTap: () {
              widget.isError = false;
            }),
      ],
    );
  }
}
