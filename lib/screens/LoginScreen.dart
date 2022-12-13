import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobdev_app/arguments/FormData.dart';
import 'package:mobdev_app/models/StorageItem.dart';
import 'package:mobdev_app/screens/Dashboard.dart';
import 'package:mobdev_app/screens/Signup.dart';
import 'package:mobdev_app/services/AuthServices.dart';
import 'package:mobdev_app/services/StorageService.dart';
import 'package:mobdev_app/widgets/CustomTextField.dart';
import 'package:mobdev_app/widgets/PasswordField.dart';
import 'package:mobdev_app/widgets/PrimaryButton.dart';



class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // StorageService _service = StorageService();
  final AuthService _authService = AuthService();
  final AuthService _firebaseAuth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: width * .9,
              child: Column(
                children: [
                  Image.asset('images/starbs2.png', height: 210, width: 210),
                  Text(
                    "Starbucks\n",
                    style: TextStyle(
                        fontFamily: 'SoDoSans',
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  CustomTextField(
                      labelText: "Email Address",
                      hintText: "Enter your email address",
                      controller: emailController,
                      textInputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PasswordField(
                    obscureText: obscurePassword,
                    onTap: handleObscurePassword,
                    labelText: "Password",
                    hintText: "Enter your password",
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                    text: "Login",
                    iconData: Icons.login,
                    onPress: () {
                      // loginWithProvider();
                      signInWithEmailAndPassword();
                      // Navigator.pushReplacementNamed(
                      //     context, Dashboard.routeName,
                      //     arguments: FormData(emailController.text));
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                      text: "Signup",
                      iconData: Icons.person_add,
                      onPress: () {
                        Navigator.pushNamed(context, Signup.routeName);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  signInWithEmailAndPassword() async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Dashboard.routeName);
    } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
    }
  }

  loginWithProvider() async {
    try {
      var user = await _authService.signInWithGoogle();
      // var accessToken = StorageItem("accessToken", user.credential?.accessToken as String);
      // await _service.saveData(accessToken);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Dashboard.routeName);
    } catch(e) {}
  }


}