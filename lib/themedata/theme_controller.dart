import 'package:get/get.dart';
import 'theme_data.dart';

class ThemeController extends GetxController {
  var clickCount = 0.obs;

  void toggleTheme() {
    clickCount.value++;
    Get.changeTheme(
      clickCount.value.isOdd ? customDarkTheme : customLightTheme,
    );
  }
}
