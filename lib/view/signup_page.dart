import 'package:flutter/material.dart';
import 'package:simple_api_app/Repository/api_repository.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({super.key, required this.showLoginPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
 

  @override
  void initState() {
    clear();
    super.initState();
  }

  void clear() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
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
    snackBar(String message) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

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
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please re-enter your password";
                        } else if (matchingPassword()) {
                          return "Your password didn't match";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Confirm password",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              var apiResponse = await ApiRepository()
                                  .registerUser(_emailController.text,
                                      _passwordController.text);
                              if (!apiResponse['status']) {
                                snackBar(apiResponse['message']);
                              } else {
                                snackBar(apiResponse['message']);
                                // ignore: use_build_context_synchronously
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => const LogInPage(showRegisterPage: () {  },)));
                              }
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
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have account?",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      InkWell(
                        onTap: widget.showLoginPage,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontSize: 14),
                          ),
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
