import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_monitoring_system/controllers/authentication_controller.dart';
import 'package:health_monitoring_system/controllers/profile_image_controller.dart';
import 'package:health_monitoring_system/controllers/user_data_controller.dart';
import 'package:health_monitoring_system/homePage/home_page.dart';
import 'package:health_monitoring_system/onboarding/onboarding.dart';
import 'package:health_monitoring_system/themedata/theme_data.dart';
import 'package:health_monitoring_system/themedata/theme_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://oxkvvmxwpzgtghodrdxz.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94a3Z2bXh3cHpndGdob2RyZHh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ4ODA1NjgsImV4cCI6MjA2MDQ1NjU2OH0.zJ43c3_tHIHYhMtMkk8bw9w2aJ99zZrX0NWNKLK4Pxc');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final AuthenticationController authenticationController =
        Get.put(AuthenticationController());
    Get.put(UsersController());
    Get.put(ProfileController());
    // final user = Supabase.instance.client.auth.currentUser;
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Health Monitoring System',
          theme: themeController.clickCount.value.isOdd
              ? customDarkTheme
              : customLightTheme,
          themeMode: ThemeMode.system,
          home: authenticationController.isAuthenticated.value
              ? const LandingHomePage()
              : const OnBoardingPage(),
        ));
  }
}
