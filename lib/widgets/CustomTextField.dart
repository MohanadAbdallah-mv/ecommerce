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
          color: TextFieldColor,
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
            style:
                TextStyle(color: widget.isError ? Colors.red : TextFieldColor),
            cursorColor: TextFieldColor,
            obscureText: widget.isPassword,
            autocorrect: !widget.isPassword,
            keyboardType: widget.isPassword
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: widget.isError ? Colors.red : TextFieldColor),
              ),
              suffixIcon: widget.isError
                  ? Icon(
                      Icons.error_outline_sharp,
                      color: Colors.red,
                    )
                  : null,
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: widget.isError ? Colors.red : TextFieldColor,
              ),
              focusedBorder: UnderlineInputBorder(
                // borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: TextFieldColor),
              ),
            ),
            onEditingComplete: widget.onEditComplete,
            focusNode: widget.focusNode,
            controller: widget.textEditingController,
            onTapOutside: ((event) {
              FocusScope.of(context).unfocus();
            }),
            onTap: () {
             setState(() {
               widget.isError = false;
             });


            }),
      ],
    );
  }
}
