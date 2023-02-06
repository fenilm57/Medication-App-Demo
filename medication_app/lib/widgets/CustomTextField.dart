import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final String initialValue;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.initialValue,
      this.obscureText = false,
      this.textInputType = TextInputType.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      // textfield with rounded corner and #4B57A3 color and text color black

      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 249, 249, 249),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xff4B57A3),
            fontWeight: FontWeight.bold, //<-- SEE HERE
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color(0xff4B57A3), //<-- SEE HERE
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color(0xff4B57A3), //<-- SEE HERE
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Color(0xff4B57A3), //<-- SEE HERE
            ),
          ),
        ),
      ),
    );
  }
}
