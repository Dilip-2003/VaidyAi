// import 'package:get/get.dart';
// import 'package:health_monitoring_system/model/chat_messages_model.dart';
// import 'package:health_monitoring_system/service/supabase_service.dart';

// class ChatsController extends GetxController {
//   var chats = <Chat>[].obs;
//   final SupabaseService _service = SupabaseService();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchChats();
//   }

//   void fetchChats() async {
//     final fetchedChats = await _service.getChats();
//     chats.assignAll(fetchedChats);
//   }

//   void createChat(String userId, String? title) async {
//     final chat = await _service.createChat(userId, title);
//     chats.insert(0, chat);
//   }
// }
