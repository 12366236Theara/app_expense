import 'package:app_cating/const/ConstSize.dart';
import 'package:app_cating/controller/sigUp_Cotroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:app_cating/view/login_screen/login_Screen.dart';
import 'package:app_cating/widget/buildTextField_custum.dart';
import 'package:app_cating/widget/buttom_custem.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SigupCotroller _sigupCotroller = Get.put(SigupCotroller());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final username = _fullNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;
      _sigupCotroller.siup(email, password, username, confirmPassword);

      // Perform sign-up logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Clean white background
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Clean white background
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Constsize.SizePandding_Screen),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Constsize.SizeBoderPadding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(
                                0xFF2E3192), // Dark blue for professionalism
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Track your expenses with ease',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: Constsize.SizeEimlen),
                        BuildTextField(
                          label: 'Full Name',
                          hintText: 'Enter your full name',
                          controller: _fullNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Constsize.SizeEimlen),
                        BuildTextField(
                          label: 'Email',
                          hintText: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+")
                                .hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Constsize.SizeEimlen),
                        BuildTextField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Constsize.SizeEimlen),
                        BuildTextField(
                          label: 'Confirm Password',
                          hintText: 'Confirm your password',
                          controller: _confirmPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Constsize.SizeEimlen),
                        Obx(
                          () => Center(
                            child: buttomCustem(
                              _sigupCotroller.isLoarding.value
                                  ? Colors.grey
                                  : Color(0xFF2E3192),
                              _sigupCotroller.isLoarding.value
                                  ? "Loading..."
                                  : "Sig Up",
                              _sigupCotroller.isLoarding.value ? null : _signUp,
                              textColor: Colors.white,
                              gradient: _sigupCotroller.isLoarding.value
                                  ? null
                                  : LinearGradient(
                                      colors: [
                                        Colors.blueAccent,
                                        Colors.purpleAccent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: Constsize.SizeEimlen),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.off(() => LoginScreen());
                                },
                                child: Text(
                                  ' Login',
                                  style: TextStyle(
                                    color: Colors
                                        .blueAccent, // Dark blue for the text
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();

    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
