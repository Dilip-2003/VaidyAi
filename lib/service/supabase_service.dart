// import 'package:health_monitoring_system/model/chat_messages_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class SupabaseService {
//   final supabase = Supabase.instance.client;

//   Future<List<Chat>> getChats() async {
//     final response = await supabase
//         .from('chats')
//         .select()
//         .order('created_at', ascending: false);
//     return (response as List).map((e) => Chat.fromJson(e)).toList();
//   }

//   Future<Chat> createChat(String userId, String? title) async {
//     final response = await supabase
//         .from('chats')
//         .insert({
//           'user_id': userId,
//           'title': title,
//         })
//         .select()
//         .single();
//     return Chat.fromJson(response);
//   }

//   Future<List<Message>> getMessages(String chatId) async {
//     final response = await supabase
//         .from('messages')
//         .select()
//         .eq('chat_id', chatId)
//         .order('created_at');
//     return (response as List).map((e) => Message.fromJson(e)).toList();
//   }

//   Future<Message> sendMessage({
//     required String chatId,
//     required String senderId,
//     required String content,
//     required String type,
//     required String role,
//   }) async {
//     final response = await supabase
//         .from('messages')
//         .insert({
//           'chat_id': chatId,
//           'sender_id': senderId,
//           'content': content,
//           'type': type,
//           'role': role,
//         })
//         .select()
//         .single();
//     return Message.fromJson(response);
//   }
// }
