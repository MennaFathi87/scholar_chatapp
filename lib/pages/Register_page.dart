import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholarchat/helper/snack_bar.dart';
import 'package:scholarchat/pages/Chat_page.dart';
import 'package:scholarchat/widgets/custome_buttton.dart';
import 'package:scholarchat/widgets/custome_Form_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String id = 'register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, pass;
  bool isLoad = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoad,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Image.asset('assets/images/scholar.png'),
                  Center(
                    child: Text(
                      'ScholarChat',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomeFormTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(height: 15),
                  CustomeFormTextField(
                    obscureText: true,
                    onChanged: (data) {
                      pass = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(height: 25),
                  CustomeButton(
                    txt: 'Register',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoad = true;
                        setState(() {});

                        try {
                          await signUpWithEmail();
                          Navigator.pushNamed(context, ChatPage.id,
                              arguments: email);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            snackbar(
                                context, 'The password provided is too weak.');
                          } else if (ex.code == 'email-already-in-use') {
                            snackbar(context,
                                'The account already exists for that email.');
                          }
                        } catch (ex) {
                          print(ex);
                          snackbar(context, 'An error occurred');
                        }

                        isLoad = false;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpWithEmail() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: pass!,
    );
  }
}
