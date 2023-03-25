import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:weight_management_app/common/custom_button.dart';
import 'package:weight_management_app/common/custom_textfield.dart';
import 'package:weight_management_app/common/loader.dart';
import 'package:weight_management_app/core/consts.dart';
import 'package:weight_management_app/core/routes.dart';
import 'package:weight_management_app/views/auth/service/auth_service.dart';
import 'package:weight_management_app/views/auth/service/database_service.dart';
import '../../../common/snackbar.dart';
import '../../../core/colors/colors.dart';
import '../../../helper/helper_functions.dart';
import '../../home/screens/home_screen.dart';
import 'register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("asset/images/img1.jpg"),
                        Text(
                          ' Welcome, \n Back',
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CustomTextField(
                          controller: emailController,
                          hinTtext: "Email",
                          prefix: const Icon(Icons.email_outlined),
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hinTtext: "Password",
                          prefix: const Icon(Icons.lock_outlined),
                          obscure: true,
                        ),
                        kHeight10,
                        CustomButton(
                            text: 'Login',
                            onTap: () {
                              login();
                            },
                            color: kBlack),
                        kHeight10,
                        Center(
                          child: Text.rich(
                            TextSpan(
                                text: "Don't have an accoutnt?  ",
                                style: TextStyle(color: kBlack, fontSize: 16),
                                children: [
                                  TextSpan(
                                      text: "Register here",
                                      style: TextStyle(
                                        color: kBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          nextScreen(
                                              context, const RegisterScreen());
                                        })
                                ]),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(
              emailController.text, passwordController.text)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(emailController.text);
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(emailController.text);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          // ignore: use_build_context_synchronously
          nextScreenReplace(context, const HomeScreen());
        } else {
          setState(() {
            isLoading = false;
            showSnackBar(context, value);
          });
        }
      });
    }
  }
}
