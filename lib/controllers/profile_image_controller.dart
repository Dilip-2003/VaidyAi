import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);
  final RxString imageUrl = ''.obs;
  final RxBool isUploading = false.obs;
  final RxString paths = ''.obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _loadImageUrl();
  }

  Future<void> _loadImageUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedUrl = prefs.getString('image_url');
    if (cachedUrl != null) {
      imageUrl.value = cachedUrl;
    }
  }

  Future<void> _saveImageUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('image_url', url);
  }

  Future<void> _saveFilePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('previous_path', path);
  }

  Future<String?> _getPreviousFilePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('previous_path');
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> uploadImage(String userId) async {
    if (imageFile.value == null) return;

    isUploading.value = true;
    try {
      final fileName = '$userId.png';
      final filePath = 'avatars/$fileName';

      await Supabase.instance.client.storage.from('avatars').upload(
          filePath, imageFile.value!,
          fileOptions: const FileOptions(upsert: true, cacheControl: '10'));

      final publicURL = Supabase.instance.client.storage
          .from('avatars')
          .getPublicUrl(filePath);

      final cacheBustedUrl =
          '$publicURL?timestamp=${DateTime.now().millisecondsSinceEpoch}';
      imageUrl.value = cacheBustedUrl;
      await _saveImageUrl(cacheBustedUrl);
      await _saveFilePath(filePath);
    } catch (e) {
      log('Upload Error: $e');
      Get.snackbar('Upload Error', e.toString());
    } finally {
      isUploading.value = false;
    }
  }
  // Future<void> uploadImage(String userId) async {
  //   if (imageFile.value == null) return;

  //   isUploading.value = true;
  //   try {
  //     final filePath = '$userId/profile.png';
  //     paths.value = filePath;
  //     await Supabase.instance.client.storage.from('avatars').upload(
  //         paths.value, imageFile.value!,
  //         fileOptions: const FileOptions(upsert: true));

  //     final publicURL = Supabase.instance.client.storage
  //         .from('avatars')
  //         .getPublicUrl(paths.value);

  //     final cacheBustedUrl =
  //         '$publicURL?timestamp=${DateTime.now().millisecondsSinceEpoch}';
  //     imageUrl.value = cacheBustedUrl;
  //     await _saveImageUrl(cacheBustedUrl);
  //     await _saveFilePath(paths.value);
  //   } catch (e) {
  //     log('Upload Error: $e');
  //     Get.snackbar('Upload Error', e.toString());
  //   } finally {
  //     isUploading.value = false;
  //   }
  // }

  Future<void> updateImage(String userId) async {
    if (imageFile.value == null) return;

    isUploading.value = true;
    try {
      final previousFilePath = await _getPreviousFilePath();
      if (previousFilePath == null) {
        Get.snackbar('Error', 'No previous image path found.');
        return;
      }

      await Supabase.instance.client.storage
          .from('avatars')
          .update(previousFilePath, imageFile.value!,
              fileOptions: const FileOptions(
                upsert: true,
                cacheControl: '10',
              ));

      final publicURL = Supabase.instance.client.storage
          .from('avatars')
          .getPublicUrl(previousFilePath);

      final cacheBustedUrl =
          '$publicURL?timestamp=${DateTime.now().millisecondsSinceEpoch}';
      imageUrl.value = cacheBustedUrl;
      await _saveImageUrl(cacheBustedUrl);
      await _saveFilePath(previousFilePath);
    } catch (e) {
      log('Update Error: $e');
      Get.snackbar('Update Error', e.toString());
    } finally {
      isUploading.value = false;
    }
  }

//   Future<void> updateImage(String userId) async {
//     if (imageFile.value == null) return;

//     isUploading.value = true;
//     try {
//       final filePath = await _getPreviousFilePath();
//       if (filePath == null) {
//         Get.snackbar('Error', 'No previous image path found.');
//         return;
//       }
//       paths.value = filePath;
//       await Supabase.instance.client.storage
//           .from('avatars')
//           .update(paths.value, imageFile.value!,
//               fileOptions: const FileOptions(
//                 upsert: false,
//               ));
//       final publicURL = Supabase.instance.client.storage
//           .from('avatars')
//           .getPublicUrl(paths.value);

//       final cacheBustedUrl =
//           '$publicURL?timestamp=${DateTime.now().millisecondsSinceEpoch}';
//       imageUrl.value = cacheBustedUrl;
//       await _saveImageUrl(cacheBustedUrl);
//       await _saveFilePath(paths.value);
//     } catch (e) {
//       log('Update Error: $e');
//       Get.snackbar('Update Error', e.toString());
//     } finally {
//       isUploading.value = false;
//     }
//   }
}
