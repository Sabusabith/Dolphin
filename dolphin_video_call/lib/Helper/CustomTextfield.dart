import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.hinttext,
      this.controller,
      this.onchanged,
      this.validator,
      this.sufix = false});

  String hinttext;
  Function(String)? onchanged;
  bool sufix;
  var controller;
  String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onChanged: widget.onchanged,
        obscureText: widget.sufix ? show : false,
        autofocus: false,
        textInputAction: TextInputAction.next,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
            suffixIcon: widget.sufix
                ? InkWell(
                    onTap: () {
                      setState(() {});
                      show = !show;
                    },
                    child: show
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        : Icon(
                            Icons.remove_red_eye,
                            color: Colors.blue,
                          ))
                : Container(
                    width: 1,
                    height: 1,
                  ),
            hintText: widget.hinttext,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.shade200,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red),
            )),
      ),
    );
  }
}
