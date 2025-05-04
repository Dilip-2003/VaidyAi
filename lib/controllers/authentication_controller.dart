import 'dart:developer';
import 'package:get/get.dart';
import 'package:health_monitoring_system/homePage/home_page.dart';
import 'package:health_monitoring_system/onboarding/onboarding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationController extends GetxController {
  final SupabaseClient _client = Supabase.instance.client;
  var isAuthenticated = false.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final session = _client.auth.currentSession;
    isAuthenticated.value = session != null;
    isLoading.value = false;
  }

  Future<void> signUp(
      String email, String password, String name, String phone) async {
    isLoading.value = true;
    try {
      final AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      final User? user = response.user;
      final Session? session = response.session;

      if (user != null && session != null) {
        // Insert user data into 'vaidyai_users' table
        final insertResponse = await _client.from('vaidyai_users').insert({
          'id': user.id,
          'email': email,
          'name': name,
          'phone': phone,
        });

        // if (insertResponse.status != 201) {
        //   log('account not created');
        // }

        isAuthenticated.value = true;
        Get.snackbar('Sign Up', 'Account created successfully!');
        Get.off(LandingHomePage());
      } else {
        Get.snackbar('Sign Up', 'Sign up failed. Please try again.');
      }
    } on AuthException catch (e) {
      Get.snackbar('Sign Up Error', e.message);
    } catch (e) {
      log(e.toString());
      Get.snackbar('Sign Up Error', 'An unexpected error occurred.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    try {
      final AuthResponse response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = response.session;
      final User? user = response.user;

      if (session != null && user != null) {
        isAuthenticated.value = true;
        Get.off(LandingHomePage());
      } else {
        Get.snackbar('Sign In', 'Unexpected error occurred during sign in.');
      }
    } on AuthException catch (e) {
      Get.snackbar('Sign In Error', e.message);
    } catch (e) {
      Get.snackbar('Sign In Error', 'An unexpected error occurred.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _client.auth.signOut();
      isAuthenticated.value = false;
      Get.off(const OnBoardingPage());
    } on AuthException catch (e) {
      Get.snackbar('Sign Out Error', e.message);
    } catch (e) {
      Get.snackbar('Sign Out Error', 'An unexpected error occurred.');
    } finally {
      isLoading.value = false;
    }
  }
}
