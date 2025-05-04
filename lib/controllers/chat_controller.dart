import 'dart:math';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatController extends GetxController {
  late types.User user;
  RxList<types.Message> messages = <types.Message>[].obs;
  RxBool isResponsePending = false.obs;

  final List<String> predefinedResponses = [
    "I'm here to help you!",
    "Let's solve this together.",
    "How can I assist you today?",
    "I'm ready to answer your questions.",
    "Feel free to ask me anything."
  ];

  String? _pendingMessageId;

  @override
  void onInit() {
    super.onInit();
    user = types.User(id: 'user123');
  }

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final file = result.files.single;

      final fileMessage = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: file.name,
        size: file.size,
        uri: file.path!,
      );

      messages.insert(0, fileMessage);
    } else {
      print("No file selected or invalid file type.");
    }
  }

  void sendMessage(types.PartialText message) {
    if (isResponsePending.value) {
      print("Please wait for the previous response.");
      return;
    }

    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    final newMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: messageId,
      text: message.text,
    );

    messages.insert(0, newMessage);
    isResponsePending.value = true;
    _pendingMessageId = messageId;

    Future.delayed(Duration(seconds: 2), () {
      if (_pendingMessageId != messageId) {
        // Message was canceled; do not send a response.
        return;
      }

      final botResponse =
          predefinedResponses[Random().nextInt(predefinedResponses.length)];
      final botMessage = types.TextMessage(
        author: types.User(id: 'bot'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: botResponse,
      );

      messages.insert(0, botMessage);
      isResponsePending.value = false;
      _pendingMessageId = null;
    });
  }

  void cancelMessage() {
    if (!isResponsePending.value || _pendingMessageId == null) {
      print("No message to cancel.");
      return;
    }

    messages.removeWhere((msg) => msg.id == _pendingMessageId);
    isResponsePending.value = false;
    _pendingMessageId = null;
  }
}

// import 'package:get/get.dart';
// import 'package:health_monitoring_system/model/chat_messages_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ChatController extends GetxController {
//   final SupabaseClient _supabase = Supabase.instance.client;

//   var chats = <Map<String, dynamic>>[].obs;
//   var messages = <Message>[].obs; // Updated to store Message objects
//   var currentChatId = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchChats();
//   }

//   Future<void> fetchChats() async {
//     final userId = _supabase.auth.currentUser?.id;
//     if (userId == null) return;

//     final response = await _supabase
//         .from('chats')
//         .select()
//         .eq('user_id', userId)
//         .order('created_at', ascending: false);

//     chats.assignAll(response);
//   }

//   Future<void> createNewChat() async {
//     final userId = _supabase.auth.currentUser?.id;
//     if (userId == null) return;

//     final response = await _supabase
//         .from('chats')
//         .insert({'user_id': userId})
//         .select()
//         .single();

//     chats.insert(0, response);
//     currentChatId.value = response['id'];
//     messages.clear();
//   }

//   Future<void> fetchMessages(String chatId) async {
//     final response = await _supabase
//         .from('messages')
//         .select()
//         .eq('chat_id', chatId)
//         .order('created_at', ascending: true);

//     // Convert each message map to a Message object
//     messages.assignAll(response.map((msg) => Message.fromMap(msg)).toList());
//   }

//   Future<void> sendMessage(String content, String type) async {
//     final userId = _supabase.auth.currentUser?.id;
//     final chatId = currentChatId.value;
//     if (userId == null || chatId.isEmpty) return;

//     final message = {
//       'chat_id': chatId,
//       'sender_id': userId,
//       'content': content,
//       'type': type,
//     };

//     final response =
//         await _supabase.from('messages').insert(message).select().single();

//     // Convert the response to a Message object and add it to the list
//     messages.add(Message.fromMap(response));
//   }
// }
