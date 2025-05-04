// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/message_controller.dart';

// class ChatPage extends StatelessWidget {
//   final String chatId;
//   final MessageController messageController = Get.put(MessageController());
//   final TextEditingController inputController = TextEditingController();

//   ChatPage({super.key, required this.chatId}) {
//     messageController.fetchMessages(chatId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => ListView.builder(
//                   itemCount: messageController.messages.length,
//                   itemBuilder: (context, index) {
//                     final msg = messageController.messages[index];
//                     return ListTile(
//                       title: Text(msg.content),
//                       subtitle: Text('${msg.role} - ${msg.type}'),
//                     );
//                   },
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: inputController,
//                     decoration: InputDecoration(hintText: 'Type a message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     final text = inputController.text.trim();
//                     if (text.isNotEmpty) {
//                       messageController.sendMessage(
//                         chatId: chatId,
//                         senderId: 'user-id-placeholder',
//                         content: text,
//                         type: 'text',
//                         role: 'user',
//                       );
//                       inputController.clear();
//                     }
//                   },
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
