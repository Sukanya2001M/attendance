// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// Future<User?> signInWithGoogle() async {
//   // Trigger the Google authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//   if (googleUser == null) {
//     // The user canceled the sign-in
//     return null;
//   }
//
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication googleAuth =
//   await googleUser.authentication;
//
//   // Create a new credential
//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//
//   // Sign in to Firebase with the Google credentials
//   final UserCredential userCredential =
//   await FirebaseAuth.instance.signInWithCredential(credential);
//
//   return userCredential.user;
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../presentation/controllers/signin_Controller.dart';
// import '../routes/page_routes.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
// final Sign_in_con signctr = Get.find();

final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: "547810480733-s2hmfis8gc451knuaj09iikbrlnj8s08.apps.googleusercontent.com"
);

Future<void> signInWithGoogle() async {
  try {
    // Sign out to ensure a clean state
    await googleSignIn.signOut();

    // Trigger Google Sign-In
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      // Get the authentication tokens
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using the credential

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the Firebase user
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {

        // Save email and UID in your controller, handling nullable values

        // await signctr.saveUserEmail(firebaseUser.email ?? "No Email");
        // await signctr.saveUseruid(firebaseUser.uid); // UID is non-nullable
        // await signctr.saveUsername(firebaseUser.displayName ?? "No Name"); // Handle nullable display name

        // Debugging outputs
        print("Display Name: ${firebaseUser.displayName}");
        print("Email: ${firebaseUser.email}");
        print("Metadata: ${firebaseUser.metadata}");
        print('signed in');
      }

      // Navigate to the dashboard
      Get.to(() => Home());
    } else {
      print('Google Sign-In was cancelled by the user');
    }
  } catch (e) {
    print('Error during Google Sign-In: $e');
  }
}


Future<bool> signOutGoogle() async {
  try {
    await googleSignIn.signOut();
    await _auth.signOut();

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('auth', false);

    return true;
  } catch (e) {
    print('Error during sign-out: $e');
    return false;
  }
}