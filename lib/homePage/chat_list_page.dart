// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:health_monitoring_system/controllers/chats_controller.dart';
// import 'package:health_monitoring_system/homePage/chat_page.dart';

// class ChatListPage extends StatelessWidget {
//   final ChatsController chatController = Get.put(ChatsController());

//   ChatListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chats')),
//       body: Obx(() => ListView.builder(
//             itemCount: chatController.chats.length,
//             itemBuilder: (context, index) {
//               final chat = chatController.chats[index];
//               return ListTile(
//                 title: Text(chat.title ?? 'Chat ${chat.id.substring(0, 4)}'),
//                 onTap: () => Get.to(() => ChatPage(chatId: chat.id)),
//               );
//             },
//           )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () =>
//             chatController.createChat('user-id-placeholder', 'New Chat'),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
