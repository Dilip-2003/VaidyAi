// class Chat {
//   final String id;
//   final DateTime createdAt;
//   final String userId;
//   final String? title;

//   Chat({
//     required this.id,
//     required this.createdAt,
//     required this.userId,
//     this.title,
//   });

//   factory Chat.fromJson(Map<String, dynamic> json) {
//     return Chat(
//       id: json['id'],
//       createdAt: DateTime.parse(json['created_at']),
//       userId: json['user_id'],
//       title: json['title'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'created_at': createdAt.toIso8601String(),
//       'user_id': userId,
//       'title': title,
//     };
//   }
// }

// class Message {
//   final String id;
//   final DateTime createdAt;
//   final String chatId;
//   final String senderId;
//   final String content;
//   final String type; // e.g., 'text', 'image', 'audio'
//   final String role; // e.g., 'user' or 'ai'

//   Message({
//     required this.id,
//     required this.createdAt,
//     required this.chatId,
//     required this.senderId,
//     required this.content,
//     required this.type,
//     required this.role,
//   });

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       id: json['id'],
//       createdAt: DateTime.parse(json['created_at']),
//       chatId: json['chat_id'],
//       senderId: json['sender_id'],
//       content: json['content'],
//       type: json['type'],
//       role: json['role'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'created_at': createdAt.toIso8601String(),
//       'chat_id': chatId,
//       'sender_id': senderId,
//       'content': content,
//       'type': type,
//       'role': role,
//     };
//   }
// }
