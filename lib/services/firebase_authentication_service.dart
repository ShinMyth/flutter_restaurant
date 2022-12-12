import 'package:restaurant/shared/shared_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signUp({required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSharedSnackbar(
          title: "Invalid Email",
          message: "Please enter a valid email.",
        );
      } else if (e.code == 'email-already-in-use') {
        showSharedSnackbar(
          title: "Email Already In Use",
          message: "Please enter another email.",
        );
      } else if (e.code == 'weak-password') {
        showSharedSnackbar(
          title: "Weak Password",
          message: "Please enter a stronger password.",
        );
      }

      return false;
    } catch (e) {
      showSharedSnackbar(
        title: "Sign Up Error",
        message: "Oops, something went wrong. Please try again later.",
      );

      return false;
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSharedSnackbar(
          title: "Invalid Email",
          message: "Please enter a valid email.",
        );
      } else if (e.code == 'user-not-found') {
        showSharedSnackbar(
          title: "Email Not Found",
          message: "Please enter another email.",
        );
      } else if (e.code == 'wrong-password') {
        showSharedSnackbar(
          title: "Wrong Password",
          message: "Please re-enter your password.",
        );
      }

      return false;
    } catch (e) {
      showSharedSnackbar(
        title: "Sign In Error",
        message: "Oops, something went wrong. Please try again later.",
      );

      return false;
    }
  }

  Future<void> updateDisplayName(
      {required String firstName, required String lastName}) async {
    await auth.currentUser!.updateDisplayName("$firstName $lastName");
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
