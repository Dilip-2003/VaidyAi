import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveImageUrl(String imageUrl) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('image_url', imageUrl);
}

Future<void> saveFilePath(String filePath) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('previous_path', filePath);
}
// Future<String?> getImageUrl() async {
//   final prefs = await SharedPreferences.getInstance();
//   final imageUrl = prefs.getString('image_url');
//   return imageUrl!;
// }
