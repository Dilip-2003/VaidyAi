import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_monitoring_system/authentication/login_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.05,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Welcome to \nHealthcare \nAssistant!',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff153D52),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/onboarding.png',
                  height: height * 0.4,
                  width: height * 0.4,
                ),
                const SizedBox(height: 20),
                Text(
                  'Analyze medical reports,\n manage health records, and get \ninsights on your health - anytime',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff134755),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.off(const LoginPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff134755),
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class WavyText extends StatefulWidget {
//   const WavyText({super.key});

//   @override
//   State<WavyText> createState() => _WavyTextState();
// }

// class _WavyTextState extends State<WavyText> with TickerProviderStateMixin {
//   final String text = "Welcome to VaidyAI";
//   late List<AnimationController> _controllers;
//   late List<Animation<double>> _animations;

//   @override
//   void initState() {
//     super.initState();
//     _controllers = List.generate(text.length, (index) {
//       return AnimationController(
//         duration: const Duration(
//             milliseconds: 500), // Each letter animates for 0.5 sec
//         vsync: this,
//       );
//     });

//     _animations = _controllers.map((controller) {
//       return Tween<double>(begin: 0, end: 1).animate(
//         CurvedAnimation(parent: controller, curve: Curves.easeInOut),
//       );
//     }).toList();

//     _startSequentialAnimation();
//   }

//   void _startSequentialAnimation() {
//     for (int i = 0; i < _controllers.length; i++) {
//       Future.delayed(Duration(milliseconds: i * 100), () {
//         if (mounted) _controllers[i].repeat();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(text.length, (index) {
//         return AnimatedBuilder(
//           animation: _animations[index],
//           builder: (context, child) {
//             double progress = _animations[index].value;
//             double waveOffset = sin(progress * pi) * 10; // Wavy effect

//             return Transform.translate(
//               offset: Offset(0, -waveOffset),
//               child: ShaderMask(
//                 shaderCallback: (bounds) => const LinearGradient(
//                   colors: [
//                     Colors.red,
//                     Colors.orange,
//                     Colors.yellow,
//                     Colors.green,
//                     Colors.blue,
//                     Colors.purple
//                   ],
//                   tileMode: TileMode.mirror,
//                 ).createShader(bounds),
//                 child: Text(
//                   text[index],
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white, // Needed for ShaderMask
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }
