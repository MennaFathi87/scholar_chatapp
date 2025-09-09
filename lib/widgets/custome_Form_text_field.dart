import 'package:flutter/material.dart';

class CustomeFormTextField extends StatefulWidget {
  const CustomeFormTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    //intailized value false
    this.obscureText = false,
  });

  final String hintText;
  final Function(String)? onChanged;
  //add obscureText
  final bool obscureText;

  @override
  State<CustomeFormTextField> createState() => _CustomeFormTextFieldState();
}

class _CustomeFormTextFieldState extends State<CustomeFormTextField> {
  //
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        //Icon obscure
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.lock : Icons.lock_open,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}

