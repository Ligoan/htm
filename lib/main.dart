import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/community_screen.dart';
import 'screens/home_screen.dart';
import 'screens/mypage_screen.dart';
//import 'community_page.dart';  // Import CommunityPage
//import 'mypage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'History Toon Maker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // 라우트
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/community': (context) => const CommunityPage(),
        '/mypage': (context) => const MyPage(),
        '/aichat': (context) => const ChatScreen(),
      },
    );
  }
}
