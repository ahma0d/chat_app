import 'package:flutter/material.dart';

class costumtextFormField extends StatelessWidget {
  costumtextFormField(
      {this.onChange, this.hinttext, this.obsecuretext = false});

  String? hinttext;
  Function(String)? onChange;
  bool? obsecuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecuretext!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Faild is required';
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 138, 119, 119),
            ),
          )),
    );
  }
}
