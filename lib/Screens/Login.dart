import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/Screens/chatpage.dart';
import 'package:scholar_chat/constant/constant.dart';

import '../Widget/Custom_Bottom.dart';
import '../Widget/coustom_text_Feild.dart';
import '../helper/show_snackbar.dart';

class logIn extends StatefulWidget {
  logIn({super.key});

  static String id = 'loginPage';

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 35,
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
                SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
                    obsecuretext: true,
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
                        await logInUser();
                        Navigator.popAndPushNamed(context, chatpage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackbar(context, 'user exist');
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
                  text: 'login',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont\'t  have an account? ',
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
                        Navigator.pushNamed(context, 'registerpage');
                      },
                      child: Text(
                        '  Register',
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

  Future<void> logInUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
