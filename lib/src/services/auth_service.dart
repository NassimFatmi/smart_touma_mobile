import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _instance = FirebaseAuth.instance;

  static FirebaseAuth get instance => _instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleSignInAccount = await GoogleSignIn().signIn();

      final googleAuth = await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await _instance.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      (e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _instance.signOut();
  }
}
