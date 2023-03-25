import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_management_app/core/routes.dart';
import 'package:weight_management_app/helper/helper_functions.dart';
import 'package:weight_management_app/views/auth/screens/auth_screen.dart';
import 'package:weight_management_app/service/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//-=-=-=-=-=-=-=-=-=-=-=-Register-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\\
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      await DatabaseService(uid: user.uid).savingUserData(fullName, email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//-=-=-=-=-=-=-=-=-=-=-=-Login-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\\
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//-=-=-=-=-=-=-=-=-=-=-=-Signout-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\\
  Future signout(context) async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);

      await HelperFunctions.saveUserEmailSF(" ");
      await HelperFunctions.saveUserNameSF(" ");
      nextScreenReplace(context, const AuthScreen());
    } catch (e) {
      return null;
    }
  }
}
