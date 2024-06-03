import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Screens/chatpage.dart';
import 'package:scholar_chat/Widget/coustom_text_Feild.dart';

import '../Widget/Custom_Bottom.dart';
import '../helper/show_snackbar.dart';

class registerpage extends StatefulWidget {
  registerpage({super.key});
  static String id = 'registerpage';
  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xff2b475e),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 110,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar chat',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),
                Row(
                  children: [
                    SizedBox(
                      height: 44,
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                costumtextFormField(
                  onChange: (data) {
                    email = data;
                  },
                  hinttext: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                costumtextFormField(
                    onChange: (data) {
                      password = data;
                    },
                    hinttext: 'password '),
                const SizedBox(
                  height: 10,
                ),
                coustomBottom(
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        showSnackbar(context, 'account created successfully');
                        Navigator.pushNamed(context, chatpage.id);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackbar(context, 'weak password');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackbar(context, 'account already exists');
                        }
                      } catch (ex) {
                        showSnackbar(context, 'something went wrong');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'register',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  Login',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xffc7ede6),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
