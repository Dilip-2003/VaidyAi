// import 'package:get/get.dart';
// import 'package:health_monitoring_system/model/chat_messages_model.dart';
// import 'package:health_monitoring_system/service/supabase_service.dart';

// class MessageController extends GetxController {
//   var messages = <Message>[].obs;
//   final SupabaseService _service = SupabaseService();

//   void fetchMessages(String chatId) async {
//     final fetchedMessages = await _service.getMessages(chatId);
//     messages.assignAll(fetchedMessages);
//   }

//   void sendMessage({
//     required String chatId,
//     required String senderId,
//     required String content,
//     required String type,
//     required String role,
//   }) async {
//     final message = await _service.sendMessage(
//       chatId: chatId,
//       senderId: senderId,
//       content: content,
//       type: type,
//       role: role,
//     );
//     messages.add(message);
//   }
// }
