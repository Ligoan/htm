import 'package:flutter/material.dart';
import 'package:myapp/screens/features/search_window.dart';

import '../widgets/event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        centerTitle: true,
        title: const Text('History Toon Maker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // 마이페이지 프로필 화면으로 이동
              Navigator.pushNamed(context, '/mypage');
            },
          ),
        ],
      ),

      // Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFBF8773),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // 추가적인 메뉴 항목을 추가할 수 있음
          ],
        ),
      ),

      // Body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/banner_image.png', // 배너 이미지 경로 설정
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),

          // 검색 창
          SearchWindow(),

          // 추천 사건 TOP 5
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '추천 사건 TOP 5',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: const [
                EventCard('6.25 전쟁', 'assets/images/625.png'),
                EventCard('삼강행실도', 'assets/images/samgang.png'),
                EventCard('순교성지', 'assets/images/sungyo.png'),
                EventCard('조선왕조실록', 'assets/images/joseon.png'),
                EventCard('울산 암구대 암각화', 'assets/images/ulsan.png'),
                EventCard('더보기', null),
              ],
            ),
          ),
        ],
      ),

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // 홈 화면을 기본 선택
        backgroundColor: const Color(0xFFBF8773),
        selectedItemColor: Colors.white, // 선택된 항목의 라벨 색상
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.diversity_3),
            label: 'Community',
            // backgroundColor: Color(0xFFBF8773), // Add a background color
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'AI Chat',
            // backgroundColor: Color(0xFFBF8773), // Add a background color
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Color(0xFFBF8773), // Add a background color
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Timeline',
            // backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            // backgroundColor: Color(0xFFBF8773), // Add a background color
          ),
        ],
        onTap: (index) {
          //   switch (index) {
          //     case 0:
          //       Navigator.pushNamed(context, '/community');
          //       break;
          //     case 1:
          //       Navigator.pushNamed(context, '/aichat');
          //       break;
          //     case 2:
          //       print('You passed.');
          //       break;
          //     case 3:
          //       print('Better try again.');
          //       break;
          //     case 4:
          //       Navigator.pushNamed(context, '/mypage');
          //       break;
          //     default:
          //       print('Invalid grade.');
          //   }
          // },

          if (index == 0) {
            // Community 스크린으로 이동
            Navigator.pushNamed(context, '/community');
          } else if (index == 1) {
            // AI Chat 스크린으로 이동
            Navigator.pushNamed(context, '/aichat');
          } else if (index == 4) {
            // // MyPage 스크린으로 이동
            // Navigator.pushNamed(context, '/mypage');
            Navigator.pushNamed(context, '/imagen_test'); // Imagen3 테스트 페이지로 이동
          }
        },
      ),
    );
  }
}
