import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helper/pref.dart';
import 'screens/chat_screen.dart';
import 'screens/community_screen.dart';
import 'screens/features/image_creator_feature.dart';
import 'screens/home_screen.dart';
import 'screens/mypage_screen.dart';
import 'screens/imagen3_test.dart';
//import 'community_page.dart';  // Import CommunityPage
//import 'mypage.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // 이 파일은 Firebase 프로젝트 설정 시 자동으로 생성됨

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Flutter에서 비동기 코드를 실행하기 전에 Flutter 엔진을 초기화
  if (Firebase.apps.isEmpty) {
    //Firebase를 여러 번 초기화하는 것을 방지
    await Firebase.initializeApp(); //Firebase 서비스를 앱에서 사용하기 위해 초기화
  }

  // init hive
  Pref.initialize();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

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
        '/imagen_test': (context) => const ImagenTestScreen(),
        '/dalle_test': (context) => const ImageCreatorFeature(),
      },
    );
  }
}
