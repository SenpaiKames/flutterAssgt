import 'package:flutter/material.dart';
import 'package:mobdev_app/screens/Dashboard.dart';
import 'package:mobdev_app/screens/LoginScreen.dart';
import 'package:mobdev_app/screens/Settings.dart';
import 'package:mobdev_app/screens/Signup.dart';
import 'package:mobdev_app/widgets/CustomTextField.dart';
import 'package:mobdev_app/widgets/PasswordField.dart';
import 'package:mobdev_app/widgets/PrimaryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobdev_app/services/AuthServices.dart';

class Signup extends StatefulWidget {
  static String routeName = "/signup";

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthService _firebaseAuth = AuthService();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
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
                  CustomTextField(
                    labelText: "First Name",
                    hintText: "Enter your first name",
                    controller: firstNameController,
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    labelText: "Last Name",
                    hintText: "Enter your last name",
                    controller: lastNameController,
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomTextField(
                    labelText: "Email Address",
                    hintText: "Enter your email address",
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
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
                  PasswordField(
                    obscureText: obscurePassword,
                    onTap: handleObscurePassword,
                    labelText: "Confirm Password",
                    hintText: "Re-enter your password",
                    controller: confirmPassController,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                    text: "Signup",
                    iconData: Icons.person_add,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                    text: "Already have an account?",
                    iconData: Icons.login,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
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

   signInWithEmail() async {
    try {
       final credential = await _firebaseAuth.createUserWithEmailAndPassword(
       email: emailController.text,
       password: passwordController.text,
        );
        Navigator.pushReplacementNamed(context, Dashboard.routeName);
      } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
              print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
          }
    } catch (e) {
        print(e);
      }
  }
}
