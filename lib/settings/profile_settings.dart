import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_monitoring_system/controllers/authentication_controller.dart';
import 'package:health_monitoring_system/controllers/profile_image_controller.dart';
import 'package:health_monitoring_system/controllers/user_data_controller.dart';
import 'package:health_monitoring_system/themedata/theme_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final width = Get.width;
  final height = Get.height;
  final authCtl = Get.find<AuthenticationController>();
  final pofileImageController = Get.find<ProfileController>();
  final usersCtl = Get.find<UsersController>();
  final String userId = Supabase.instance.client.auth.currentUser!.id;
  String? localImageUrl;

  // Future<void> getImageUrl() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final fetchedUrl = prefs.getString('image_url');
  //   if (mounted) {
  //     setState(() {
  //       localImageUrl = fetchedUrl;
  //     });
  //   }
  // }

  void showImageOptions() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('View Profile Picture'),
              onTap: () {
                Navigator.pop(context);
                final imageUrl = pofileImageController.imageUrl.value;
                if (imageUrl.isNotEmpty) {
                  // getImageUrl();
                  Get.to(() => FullImageView(url: imageUrl));
                } else {
                  Get.snackbar('No Image', 'No profile picture available.');
                }
              },
            ),
            Obx(() {
              final imageUrl = pofileImageController.imageUrl.value;
              return ListTile(
                leading: const Icon(Icons.upload),
                title: Text(imageUrl.isNotEmpty
                    ? 'Update New Image'
                    : 'Upload New Image'),
                onTap: () async {
                  Navigator.pop(context);
                  await pofileImageController.pickImage();
                  if (pofileImageController.imageFile.value != null) {
                    if (imageUrl.isNotEmpty) {
                      await pofileImageController.updateImage(userId);
                    } else {
                      await pofileImageController.uploadImage(userId);
                    }
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    usersCtl.fetchUsers(userId);
    // getImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (usersCtl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (usersCtl.users.isEmpty) {
          return const Center(child: Text('No profile data available'));
        }
        final user = usersCtl.users.first;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => showImageOptions(),
                      child: Obx(
                        () {
                          final imageUrl = pofileImageController.imageUrl.value;
                          // getImageUrl();
                          return pofileImageController.isUploading.value
                              ? const CircularProgressIndicator(
                                  // value: 50,
                                  strokeWidth: 15,
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  backgroundImage: (imageUrl.isNotEmpty)
                                      ? NetworkImage(imageUrl)
                                      : null,
                                  child: (imageUrl.isEmpty)
                                      ? const Icon(Icons.person, size: 50)
                                      : null,
                                );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomCard(
                icon: Icons.email,
                title: 'Email',
                subtitle: user.email,
                onTap: () => log('email clicked'),
              ),
              CustomCard(
                icon: Icons.phone,
                title: 'Phone Number',
                subtitle: '+91-${user.phone}',
                onTap: () => log('phone clicked'),
              ),
              CustomCard(
                icon: Icons.light_mode,
                title: 'Theme',
                onTap: () {
                  Get.find<ThemeController>().toggleTheme();
                  log('theme toggled');
                },
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  authCtl.signOut();
                  log('logout clicked');
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  color: Theme.of(context).cardColor,
                  surfaceTintColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Obx(() {
                          return authCtl.isLoading.value
                              ? CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                )
                              : const Icon(Icons.logout, size: 35.0);
                        }),
                        const SizedBox(width: 16.0),
                        Text(
                          'Logout',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// full image view
class FullImageView extends StatelessWidget {
  final String url;

  const FullImageView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile Picture'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.network(
          url,
          // height: 250,
          // width: 250,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// CustomCard remains unchanged
class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle = '',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
        color: Theme.of(context).cardColor,
        surfaceTintColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 35.0),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
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
