import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:weight_management_app/core/common/snackbar.dart';
import 'package:weight_management_app/helper/helper_functions.dart';
import 'package:weight_management_app/service/auth_service.dart';
import 'package:weight_management_app/views/auth/screens/auth_screen.dart';
import '../../../core/common/custom_button.dart';
import '../../../core/common/custom_textfield.dart';
import '../../../core/common/loader.dart';
import '../../../core/colors/colors.dart';
import '../../../core/consts.dart';
import '../../../core/routes.dart';
import '../../home/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  AuthService authservice = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: isLoading
          ? const Loader()
          : Form(
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
                      controller: nameController,
                      hinTtext: "Name",
                      prefix: const Icon(Icons.person),
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
                        text: 'Register',
                        onTap: () {
                          regiser();
                        },
                        color: kBlack),
                    kHeight10,
                    Center(
                      child: Text.rich(
                        TextSpan(
                            text: "Already have an accoun?  ",
                            style: TextStyle(color: kBlack, fontSize: 16),
                            children: [
                              TextSpan(
                                  text: "Login now",
                                  style: TextStyle(
                                    color: kBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      nextScreen(context, const AuthScreen());
                                    })
                            ]),
                      ),
                    )
                  ],
                ),
              )),
    ));
  }

  regiser() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authservice
          .registerUserWithEmailandPassword(nameController.text,
              emailController.text, passwordController.text)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(emailController.text);
          await HelperFunctions.saveUserNameSF(nameController.text);
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
