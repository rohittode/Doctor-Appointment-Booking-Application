
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controlers/auth_controller.dart';
import 'package:mediapp/views/appointment_view/appointment_view.dart';
import 'package:mediapp/views/home_view/home.dart';
import 'package:mediapp/views/signup_view/signup_view.dart';
import 'package:mediapp/views/forgot_pass_outside/fogot_pass_outside.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:mediapp/views/doc_view.dart';

String? _validateEmail(value) {
  if (value!.isEmpty) {
    return 'Please enter an email';
  }
  RegExp emailRegex = RegExp(r'^[\w\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var isDoctor = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.icLogin,
                  width: 200,
                ),
                const SizedBox(height: 16),
                Text(
                  AppStrings.welcomeBack,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  AppStrings.weAreExcited,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: AppStrings.email,
                          labelText: AppStrings.email,
                          prefixIcon: const Icon(Icons.email),
                          border: const OutlineInputBorder(),
                        ),
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        controller: controller.passwordController,
                        obscureText: !_isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (password) => password!.length < 6
                            ? 'Password should be at least 6 characters'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      SwitchListTile(
                        value: isDoctor,
                        onChanged: (newValue) {
                          setState(() {
                            isDoctor = newValue;
                          });
                        },
                        title: Text(
                          AppStrings.signInDoctor,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () async {
                            Get.to(() => const PasswordResetPage());
                          },
                          child: Text(
                            AppStrings.forgetPassword,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          final email = controller.emailController.text.trim();
                          final password =
                              controller.passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar(
                              AppStrings.error,
                              AppStrings.validEmailPassword,
                            );
                            return;
                          }

                          try {
                            await controller.loginUser(
                              email: email,
                              password: password,
                            );

                            if (controller.userCredential != null) {
                              if (isDoctor) {
                                Get.to(() => const DocView());
                              } else {
                                Get.to(() => const Home());
                              }
                              VxToast.show(context, msg: "Login Successful");
                            } else {
                              VxToast.show(context,
                                  msg: "Login Failed! Check the details");
                            }
                          } on FirebaseAuthException catch (e) {
                            String errorMessage;
                            switch (e.code) {
                              case 'user-not-found':
                                errorMessage = 'No user found for that email.';
                                break;
                              case 'wrong-password':
                                errorMessage =
                                    'Wrong password provided for that user.';
                                break;
                              default:
                                errorMessage =
                                    'Incorrect Details Please try again.';
                            }
                            Get.snackbar(
                              AppStrings.error,
                              errorMessage,
                            );
                          } catch (e) {
                            Get.snackbar(
                              AppStrings.error,
                              'An unexpected error occurred. Please try again.',
                            );
                          }
                        },
                        child: Text(AppStrings.login),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.dontHaveAccount,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const SignupView());
                            },
                            child: Text(
                              AppStrings.signup,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
