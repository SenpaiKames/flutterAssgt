import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

   User? get currentUser => _firebaseAuth.currentUser;
   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

   Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
   }) async {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
   }

   Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
   }) async {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
   }

   Future<void> signOut() async {
      await _firebaseAuth.signOut();
   }

   static GoogleSignIn googleSignIn = GoogleSignIn();

   GoogleSignInAccount? user;

   Future<UserCredential> signInWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
   

    final GoogleSignInAuthentication? googleAuth = 
    await googleUser?.authentication;

    final credential =  GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken
     );

    return await FirebaseAuth.instance.signInWithCredential(credential);
   }
   
   Future logout() async {
      try{
        await googleSignIn.disconnect();
        await FirebaseAuth.instance.signOut();
      }catch(e){
        return null;
      }
   }

}




