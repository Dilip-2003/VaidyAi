import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:health_monitoring_system/controllers/chat_controller.dart';
import 'package:health_monitoring_system/controllers/profile_image_controller.dart';
import 'package:health_monitoring_system/homePage/custom_chat_input.dart';
import 'package:health_monitoring_system/settings/profile_settings.dart';
import 'package:health_monitoring_system/themedata/theme_data.dart';

class LandingHomePage extends StatefulWidget {
  const LandingHomePage({super.key});

  @override
  State<LandingHomePage> createState() => _LandingHomePageState();
}

class _LandingHomePageState extends State<LandingHomePage> {
  final pofileImageController = Get.find<ProfileController>();

  // String? imageUrl;
  // Future<void> getImageUrl() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final fetchedUrl = prefs.getString('image_url');
  //   if (mounted) {
  //     setState(() {
  //       imageUrl = fetchedUrl;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    // getImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());
    // final ThemeController themeController = Get.put(ThemeController());
    final ThemeData themeData = Theme.of(context);
    final ChatTheme chatTheme = createCustomChatTheme(themeData);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Left Side Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Implement logout
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('VaidyAI'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Get.to(const ProfileSettings());
              },
              child: Obx(
                () {
                  final imageUrl = pofileImageController.imageUrl.value;
                  return pofileImageController.isUploading.value
                      ? CircularProgressIndicator(
                          strokeWidth: 10.0,
                          color: Theme.of(context).primaryColor,
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          backgroundImage: (imageUrl.isNotEmpty)
                              ? NetworkImage(imageUrl)
                              : null,
                          child: (imageUrl.isEmpty)
                              ? const Icon(
                                  Icons.person,
                                )
                              : null,
                        );
                },
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
                child: Chat(
              messages: chatController.messages,
              onSendPressed: chatController.sendMessage,
              user: chatController.user,
              showUserAvatars: false,
              showUserNames: false,
              theme: chatTheme,
              customBottomWidget: CustomInput(
                isResponsePending: chatController.isResponsePending.value,
                onSendPressed: chatController.sendMessage,
                onCancelPressed: chatController.cancelMessage,
                onFilePressed: chatController
                    .handleFileSelection, // File selection function passed here
              ),
            )),
          ],
        );
      }),
    );
  }
}
