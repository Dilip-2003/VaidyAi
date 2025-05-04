import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_monitoring_system/authentication/sign_up_page.dart';
import 'package:health_monitoring_system/controllers/authentication_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
    ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  bool isObscure = true;
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: emailController,
            style: TextStyle(color: textColor),
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
              fillColor: isDark ? Colors.transparent : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1, color: primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: passwordController,
            obscureText: isObscure,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: textColor,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              hintText: 'Enter your password',
              fillColor: isDark ? Colors.transparent : Colors.white,
              hintStyle: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor.withOpacity(0.7),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1, color: primaryColor),
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          SizedBox(
            width: width * 0.9,
            child: Obx(() {
              if (authenticationController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  final password = passwordController.text;

                  if (!email.contains('@')) {
                    Get.snackbar(
                        'Invalid Email', 'Please enter a valid email address.');
                    return;
                  }

                  if (password.length < 8) {
                    Get.snackbar('Invalid Password',
                        'Password must be at least 8 characters long.');
                    return;
                  }

                  authenticationController.signIn(email, password);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: TextStyle(color: textColor),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.off(const SignUpPage());
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
