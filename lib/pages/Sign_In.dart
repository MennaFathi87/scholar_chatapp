import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholarchat/constant.dart';
import 'package:scholarchat/helper/snack_bar.dart';
import 'package:scholarchat/pages/Chat_page.dart';
import 'package:scholarchat/pages/Register_page.dart';
import 'package:scholarchat/widgets/custome_buttton.dart';
import 'package:scholarchat/widgets/custome_Form_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static String id = 'login_page';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Image.asset(kLogo),
                    SizedBox(height: 25),
                    Text(
                      'ScholarChat',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Text(
                          'SIGN IN',
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
                      txt: 'Sign In',
                      onTap: () async {
                        //validate data 
                        if (formKey.currentState!.validate()) {
                          isLoad = true;
                          setState(() {});

                          try {
                            //firbase auth
                            await signInUser();
                            Navigator.pushNamed(
                              context,
                              ChatPage.id,
                              //
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              snackbar(
                                  context, 'No user found for that email.');
                            } else if (ex.code == 'wrong-password') {
                              snackbar(context,
                                  'Wrong password provided for that user.');
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Color(0xFF39464C)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            '  Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: pass!,
    );
  }
}
