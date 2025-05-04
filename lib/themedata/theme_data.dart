import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

final ThemeData customLightTheme = ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
    foregroundColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: const TextStyle(color: Colors.black54),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade900,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
  ),
  iconTheme: const IconThemeData(color: Colors.black87),
);

final ThemeData customDarkTheme = ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  brightness: Brightness.dark,
  cardColor: Colors.grey.shade900,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2805D5),
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black87,
    foregroundColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade800,
    hintStyle: const TextStyle(color: Colors.white70),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white38),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
);

DefaultChatTheme createCustomChatTheme(ThemeData themeData) {
  final bool isDark = themeData.brightness == Brightness.dark;

  return DefaultChatTheme(
    primaryColor: themeData.primaryColor,
    backgroundColor: themeData.scaffoldBackgroundColor,
    inputBackgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
    inputTextColor: isDark ? Colors.white : Colors.black,
    inputTextStyle: themeData.textTheme.bodyLarge ?? const TextStyle(),
    messageBorderRadius: 15.0,
    messageInsetsHorizontal: 20.0,
    messageInsetsVertical: 16.0,
    messageMaxWidth: 440.0,
    sentMessageBodyTextStyle: getMessageTextStyle(themeData, true),
    receivedMessageBodyTextStyle: getMessageTextStyle(themeData, false),
    sentMessageCaptionTextStyle:
        themeData.textTheme.bodyLarge ?? const TextStyle(),
    receivedMessageCaptionTextStyle:
        themeData.textTheme.bodyLarge ?? const TextStyle(),
    sentMessageLinkTitleTextStyle:
        themeData.textTheme.bodyLarge ?? const TextStyle(),
    receivedMessageLinkTitleTextStyle:
        themeData.textTheme.bodyLarge ?? const TextStyle(),
    sentMessageLinkDescriptionTextStyle:
        themeData.textTheme.bodyLarge ?? const TextStyle(),
    receivedMessageLinkDescriptionTextStyle:
        themeData.textTheme.bodyLarge ?? const TextStyle(),
    inputTextDecoration: const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
    ),
    inputTextCursorColor: themeData.scaffoldBackgroundColor,
    inputPadding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
  );
}

TextStyle getMessageTextStyle(ThemeData themeData, bool isSent) {
  if (isSent) {
    return themeData.textTheme.bodyLarge?.copyWith(
          color: Colors.white,
        ) ??
        const TextStyle();
  } else {
    return themeData.textTheme.bodyLarge?.copyWith(
          color: Colors.black,
        ) ??
        const TextStyle();
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';

// final ThemeData customLightTheme = ThemeData(
//   primaryColor: Colors.white,
//   scaffoldBackgroundColor: Colors.white,
//   brightness: Brightness.light,
//   cardColor: Colors.white,
//   appBarTheme: AppBarTheme(
//     backgroundColor: Colors.grey.shade900,
//     foregroundColor: Colors.white,
//   ),
//   drawerTheme: const DrawerThemeData(
//     backgroundColor: Colors.white,
//   ),
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(fontSize: 24, color: Colors.black),
//     bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
//   ),
// );

// final ThemeData customDarkTheme = ThemeData(
//   primaryColor: Colors.white,
//   scaffoldBackgroundColor: Colors.black,
//   brightness: Brightness.dark,
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.black87,
//     foregroundColor: Colors.white,
//   ),
//   drawerTheme: const DrawerThemeData(
//     backgroundColor: Colors.black,
//   ),
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(fontSize: 24, color: Colors.white),
//     bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
//   ),
// );

// DefaultChatTheme createCustomChatTheme(ThemeData themeData) {
//   return DefaultChatTheme(
//     primaryColor: themeData.primaryColor,
//     backgroundColor: themeData.scaffoldBackgroundColor,
//     inputBackgroundColor: themeData.primaryColor,
//     inputTextColor: Colors.white,
//     inputTextStyle: themeData.textTheme.bodyLarge ?? const TextStyle(),
//     messageBorderRadius: 15.0,
//     messageInsetsHorizontal: 20.0,
//     messageInsetsVertical: 16.0,
//     messageMaxWidth: 440.0,
//     sentMessageBodyTextStyle: getMessageTextStyle(themeData, true),
//     receivedMessageBodyTextStyle: getMessageTextStyle(themeData, false),
//     sentMessageCaptionTextStyle:
//         themeData.textTheme.bodyLarge ?? const TextStyle(),
//     receivedMessageCaptionTextStyle:
//         themeData.textTheme.bodyLarge ?? const TextStyle(),
//     sentMessageLinkTitleTextStyle:
//         themeData.textTheme.bodyLarge ?? const TextStyle(),
//     receivedMessageLinkTitleTextStyle:
//         themeData.textTheme.bodyLarge ?? const TextStyle(),
//     sentMessageLinkDescriptionTextStyle:
//         themeData.textTheme.bodyLarge ?? const TextStyle(),
//     receivedMessageLinkDescriptionTextStyle:
//         themeData.textTheme.bodyLarge ?? const TextStyle(),
//     inputTextDecoration: const InputDecoration(
//       border: InputBorder.none,
//       contentPadding: EdgeInsets.zero,
//       isCollapsed: true,
//     ),
//     inputTextCursorColor: themeData.scaffoldBackgroundColor,
//     inputPadding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
//   );
// }

// TextStyle getMessageTextStyle(ThemeData themeData, bool isSent) {
//   if (isSent) {
//     return themeData.textTheme.bodyLarge?.copyWith(
//           color: Colors.white,
//         ) ??
//         TextStyle();
//   } else {
//     return themeData.textTheme.bodyLarge?.copyWith(
//           color: Colors.black,
//         ) ??
//         TextStyle();
//   }
// }
