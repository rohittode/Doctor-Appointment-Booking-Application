// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
// import 'package:mediapp/consts/strings.dart';
import 'package:mediapp/controlers/auth_controller.dart';
import 'package:mediapp/controlers/email_auth_controller.dart';
import 'package:mediapp/res/components/custom_button.dart';
import 'package:mediapp/views/home_view/home.dart';
// import 'package:email_auth/email_auth.dart';
// import 'package:mediapp/controlers/email_auth_controller.dart';

String? _selectedGender;

String? _validateEmail(value) {
  if (value!.isEmpty) {
    return 'Please enter an eamil';
  }
  RegExp emailRegex = RegExp(r'^[\w\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

class SignupView extends StatefulWidget {
  const SignupView({super.key, String? verificationid});
  // EmailAuthController emailAuthController = Get.put(EmailAuthController());

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  var isDoctor = false;
  final _formKey = GlobalKey<FormState>();
  late PhoneNumber phoneNumber;

  EmailAuthController emailAuthController = Get.put(EmailAuthController());

  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _otpController = TextEditingController();
  // final TextEditingController _phnno = TextEditingController();

  // EmailAuth emailAuth = EmailAuth(sessionName: "Sample session");

  bool isEmailSent = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                AppAssets.imgSignup,
                width: 200,
              ),
              const SizedBox(height: 20),
              Text(
                AppStrings.signupNow,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: AppStrings.fullname,
                        labelText: "Name",
                        border: const OutlineInputBorder(),
                      ),
                      controller: controller.fullnameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Name cannot contain numbers';
                        }
                        if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                          return 'Name cannot contain special characters';
                        }
                        // No need for validation here since the inputFormatters restrict input to letters only
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: AppStrings.email,
                                labelText: "Email",
                                border: const OutlineInputBorder(),
                              ),
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail),
                        ),
                        // TextButton(
                        //   child: Text("Send OTP"),
                        //   onPressed: () {
                        //     emailAuthController.sendOTP(
                        //         controller.emailController.text.trim());
                        //   },
                        // ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // TextFormField(
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   keyboardType: TextInputType.phone,
                    //   decoration: InputDecoration(
                    //     hintText: "OTP",
                    //     labelText: "Enter OTP",
                    //     suffixIcon: TextButton(
                    //       child: const Text("Verify OTP"),
                    //       onPressed: () {},
                    //     ),
                    //     border: const OutlineInputBorder(),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: AppStrings.password,
                        labelText: "Password",
                        border: const OutlineInputBorder(),
                      ),
                      controller: controller.passwordController,
                      validator: (password) => password!.length < 6
                          ? 'Password  should be atleast 6 characters'
                          : null,
                    ),
                    const SizedBox(height: 20),
                   DropdownButtonFormField<String>(
  value: controller.genderController.text.isEmpty ? null : controller.genderController.text,
  onChanged: (newValue) {
    setState(() {
      controller.genderController.text = newValue!;
    });
  },
  items: <String>['Male', 'Female', 'Other']
      .map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  decoration: const InputDecoration(
    labelText: 'Gender',
    hintText: 'Select your gender',
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  },
),

                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        hintText: 'Enter your age',
                        border: OutlineInputBorder(),
                      ),
                      controller: controller.ageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        if (value.length > 2) {
                          return 'Please dont fake age';
                        }
                        int age =
                            int.tryParse(value)!; // Convert string to integer
                        if (age <= 0) {
                          return 'Age must be greater than zero';
                        }
                        // You can add more validation logic here if needed
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // IntlPhoneField(
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Phone Number',
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(),
                    //     ),
                    //   ),
                    //   initialCountryCode:
                    //       'IN', // Default country code set to India
                    //   onChanged: (phone) {
                    //     phoneNumber = phone;
                    //   },
                    //   // validator: validatePhoneNumber,
                    //   validator: (phone) {
                    //     if (phone == null || phone.number.isEmpty) {
                    //       return 'Please enter a valid phone number';
                    //     }

                    //     if (phone.countryISOCode == 'IN') {
                    //       final indianPhoneRegExp = RegExp(r'^[6-9]\d{9}$');
                    //       if (!indianPhoneRegExp.hasMatch(phone.number)) {
                    //         return 'Please enter a valid Indian phone number';
                    //       }
                    //     }
                    //   },
                    // ),
                    // const SizedBox(height: 20),

                    const SizedBox(height: 20),
              TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: "Enter your mobile number",
        labelText: "Mobile Number",
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(),
      ),
      controller: controller.signinmobileController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter Phone number';
        }
        RegExp indianPhoneNumberRegExp = RegExp(r'^[7-9]\d{9}$');
        if (!indianPhoneNumberRegExp.hasMatch(value)) {
          return 'Please enter a valid 10 digit Indian phone number';
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          "Sign up as a doctor",
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: isDoctor,
                          onChanged: (newValue) {
                            setState(() {
                              isDoctor = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isDoctor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "About",
                              labelText: "About",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            controller: controller.aboutController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter about';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Category",
                              labelText: "Category",
                              border: OutlineInputBorder(),
                            ),
                            controller: controller.categoryController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Category';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Address",
                              labelText: "Address",
                              border: OutlineInputBorder(),
                            ),
                            controller: controller.addressController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              hintText: "Timing",
                              labelText: "Timing",
                              border: OutlineInputBorder(),
                            ),
                            controller: controller.timingController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      buttonText: AppStrings.signup,
                      onTap: () async {
                        await controller.signupUser(isDoctor);
                        if (controller.userCredential != null) {
                          Get.offAll(() => const Home());
                          // VxToast.show(context, msg: "Signup Sucessfull");
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.alreadyHaveAccount,
                        style: TextStyle(fontSize: 18),),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            AppStrings.login,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
