import 'package:flutter/material.dart';
import 'package:simple_api_app/login_page.dart';
import 'package:simple_api_app/network/repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  bool matchingPassword() {
    if (_passwordController.text != _confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      "Create",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    const Text(
                      "your account",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //* Name
                    // TextFormField(
                    //   controller: _nameController,
                    //   validator: (value) {
                    //     if (value!.isEmpty ||
                    //         !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    //       return "Enter Correct Name";
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    //   decoration: const InputDecoration(
                    //     hintText: "Enter Your Name",
                    //     hintStyle: TextStyle(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    //* Email
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                          return "Enter Your Email";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Enter Your Email",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //* Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value)) {
                          return "Enter valid password";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //*Confirm Password
                    // TextFormField(
                    //   controller: _confirmPasswordController,
                    //   obscureText: true,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "please re-enter your password";
                    //     } else if (matchingPassword()) {
                    //       return "Your password didn't match";
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    //   decoration: const InputDecoration(
                    //     hintText: "Confirm password",
                    //     hintStyle: TextStyle(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                            fixedSize: MaterialStatePropertyAll(Size(147, 51)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black87),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ApiRepository().registerUser(
                                  _emailController.text,
                                  _passwordController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Submitting form")));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LogInPage()));
                            }
                          },
                          child: const Center(
                              child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          )),
                        )),
                    // child: GestureDetector(
                    //   onTap: () {
                    //     print("clicked");
                    //   },
                    //   child: Container(
                    //     width: 147,
                    //     height: 51,
                    //     // alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         color: const Color(0xff2D201C),
                    //         borderRadius: BorderRadius.circular(30)),
                    //     child: const Center(
                    //         child: Text(
                    //       "SIGN UP",
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w700,
                    //           fontSize: 16),
                    //     )),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // const Center(
                  //     child: Text(
                  //   "or sign up with",
                  //   style: TextStyle(color: Colors.black, fontSize: 12),
                  // )),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 0),
                  //       child: Container(
                  //         width: 42,
                  //         height: 42,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border:
                  //                 Border.all(color: const Color(0xffE2E0DF))),
                  //         child: Center(
                  //           child: Image.asset(
                  //             "assets/images/apple.png",
                  //             width: 22,
                  //             height: 22,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20),
                  //       child: Container(
                  //         width: 42,
                  //         height: 42,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border:
                  //                 Border.all(color: const Color(0xffE2E0DF))),
                  //         child: Center(
                  //           child: Image.asset(
                  //             "assets/images/google.png",
                  //             width: 22,
                  //             height: 22,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account?",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
