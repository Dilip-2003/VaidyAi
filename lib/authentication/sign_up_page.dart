import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_monitoring_system/authentication/login_page.dart';
import 'package:health_monitoring_system/controllers/authentication_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.05,
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                width: width * 0.9,
                height: height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Image.asset(
                        'assets/logo/logo.png',
                        height: height * 0.12,
                        width: height * 0.12,
                        color: isDark
                            ? const Color(0xFF2805D5)
                            : const Color(0xff144956),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: Text(
                        'Healthcare Assistant',
                        softWrap: true,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? const Color(0xFF2805D5)
                                : const Color(0xff144956),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.7,
                width: width,
                child: const LoginForm(),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscure1 = true;
  bool isObscure2 = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  var width = Get.width;
  var height = Get.height;
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final primaryColor =
        isDark ? const Color(0xFF2805D5) : const Color(0xff144956);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign up',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'Enter your name',
              hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // ignore: deprecated_member_use
                  color: textColor?.withOpacity(0.7),
                ),
              ),
              // filled: true,
              fillColor: isDark ? Colors.transparent : Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xff134755)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
              hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // ignore: deprecated_member_use
                  color: textColor!.withOpacity(0.7),
                ),
              ),
              // filled: true,
              fillColor: isDark ? Colors.transparent : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xff134755)),
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // ignore: deprecated_member_use
                  color: textColor.withOpacity(0.7),
                ),
              ),
              // filled: true,
              fillColor: isDark ? Colors.transparent : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xff134755)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // ignore: deprecated_member_use
                  color: textColor.withOpacity(0.7),
                ),
              ),
              // filled: true,
              fillColor: isDark ? Colors.transparent : Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xff134755)),
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure1 = !isObscure1;
                    });
                  },
                  icon: Icon(
                    isObscure1 ? Icons.visibility_off : Icons.visibility,
                  )),
            ),
            obscureText: isObscure1,
            // keyboardType: TextInputType.visiblePassword,
          ),

          const SizedBox(height: 20),
          TextField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
              hintText: 'Confirm your password',
              hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // ignore: deprecated_member_use
                  color: textColor.withOpacity(0.7),
                ),
              ),
              // filled: true,
              fillColor: isDark ? Colors.transparent : Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xff134755)),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObscure2 ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isObscure2 = !isObscure2;
                  });
                },
              ),
            ),
            obscureText: isObscure2,
            // keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: width * 0.9,
            child: Obx(() => authenticationController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      String email = emailController.text.trim();
                      String phone = phoneController.text;
                      String password = passwordController.text;
                      String confirmPassword = confirmPasswordController.text;
                      if (name.isEmpty) {
                        Get.snackbar('Invalid Name', 'Please Enter your name');
                        return;
                      }
                      if (phone.isEmpty) {
                        Get.snackbar('Invalid phone number',
                            'Please Enter your phone number');
                        return;
                      } else if (phone.length != 10) {
                        Get.snackbar('Invalid phone number',
                            'phone number should be of 10 digits');
                        return;
                      }
                      if (!email.contains('@')) {
                        Get.snackbar('Invalid Email',
                            'Please enter a valid email address.');
                        return;
                      }
                      if (password == confirmPassword) {
                        if (password.length < 8 || confirmPassword.length < 8) {
                          Get.snackbar('Invalid Password',
                              'Password must be at least 8 characters long.');
                          return;
                        }
                      } else {
                        Get.snackbar('Invalid Password',
                            'password and confirm password should be same');
                        return;
                      }
                      authenticationController.signUp(
                          email, password, name, phone);
                      // Handle login action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? const Color(0xFF2805D5)
                          : const Color(0xff144956),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
          ), //
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(color: textColor),
                children: [
                  TextSpan(
                    text: 'login',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle sign-up action
                        Get.off(const LoginPage());
                      },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
