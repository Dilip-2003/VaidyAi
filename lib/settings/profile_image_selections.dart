// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:health_monitoring_system/controllers/profile_image_controller.dart';

// class ProfilePage extends StatelessWidget {
//   final ProfileController controller = Get.put(ProfileController());

//   ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: Center(
//         child: Obx(() {
//           return GestureDetector(
//             onTap: () => _showImageOptions(context),
//             child: CircleAvatar(
//               radius: 50,
//               backgroundImage: controller.imageFile.value != null
//                   ? FileImage(controller.imageFile.value!)
//                   : (controller.imageUrl.value.isNotEmpty
//                       ? NetworkImage(controller.imageUrl.value)
//                       : null) as ImageProvider?,
//               child: controller.imageFile.value == null &&
//                       controller.imageUrl.value.isEmpty
//                   ? const Icon(Icons.person, size: 50)
//                   : null,
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   void _showImageOptions(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Profile Picture'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.image),
//               title: const Text('View Profile Picture'),
//               onTap: () {
//                 Navigator.pop(context);
//                 if (controller.imageUrl.value.isNotEmpty) {
//                   Get.to(() => FullImageView(url: controller.imageUrl.value));
//                 } else {
//                   Get.snackbar('No Image', 'No profile picture available.');
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.upload),
//               title: const Text('Upload New Image'),
//               onTap: () async {
//                 Navigator.pop(context);
//                 await controller.pickImage();
//                 if (controller.imageFile.value != null) {
//                   await controller.uploadImage();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FullImageView extends StatelessWidget {
//   final String url;

//   const FullImageView({Key? key, required this.url}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Full Image')),
//       body: Center(
//         child: Image.network(url),
//       ),
//     );
//   }
// }
