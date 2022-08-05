import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_two/pages/sign_in_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/hive_service.dart';
import '../services/util_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String id = "sign_up_page";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void _goSignIn(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  void _signUp(){

    String firstName = _firstNameController.text.trim();
    String lastname = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String name = "$firstName $lastname";

    if(firstName.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty) {
      Utils.fireSnackBar("Please fill all gaps", context);
      return;
    }
    isLoading = true;
    setState(() {});
    AuthService.signUpUser(context, name, email, password).then((user) => _checkNewUser(user));
  }
  void _checkNewUser(User? user) async {
    if(user != null) {
      await HiveService.setData(StorageKey.uid, user.uid);
      if(mounted) Navigator.pushReplacementNamed(context, SignInPage.id);
    } else {
      Utils.fireSnackBar("Please check your entered data, Please try again!", context);
    }

    isLoading = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text("SignUpPage")
        ),
        body:  Stack(
          children: [
            Center(child: isLoading ? const CircularProgressIndicator(): null),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange.shade200
                      ),
                      child: TextField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: "First name"
                        ),
                        style: const TextStyle(color: Colors.white
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange.shade200
                      ),
                      child: TextField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: "Last name"
                        ),
                        style: const TextStyle(color: Colors.white
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange.shade200
                      ),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: "Email"
                        ),
                        style: const TextStyle(color: Colors.white
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange.shade200
                      ),
                      child: TextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: "Password"
                        ),
                        style: const TextStyle(color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: MediaQuery.of(context).size.width < 600
                            ? const Size(double.infinity, 50)
                            : const Size(500, 50),
                      ),
                      child: const Text("Sign Up"),),
                    const SizedBox(height: 20,),
                    Text.rich(
                        TextSpan(
                            style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                            children: [
                              const TextSpan(
                                text: "Already have an account?  ",
                              ),
                              TextSpan(
                                style: const TextStyle(color: Colors.orange),
                                text: "Sign In",
                                recognizer: TapGestureRecognizer()..onTap = _goSignIn,
                              ),
                            ]
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
