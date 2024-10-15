import 'package:flutter/material.dart';

import '../widgets/status_card.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        centerTitle: true,
        title: const Text('마이페이지'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);  // Goes back to the previous screen
        //   },
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/'); // Navigates back to HomeScreen
            },
          ),
        ],
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center, // Aligns children in the center
              children: [
                // 프로필 이미지
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                Positioned(
                  bottom:
                      1, // Places the camera icon at the bottom of the avatar
                  right: -10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // 프로필 이미지 변경 로직 추가
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
                height: 20), // Adjust the spacing between the avatar and text

            // 사용자 ID
            const Text(
              'elena123',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 40,
            ), // Adjust the spacing between the text and the rest of the content
            const Text(
              '내가 만든 이미지/웹툰 현황',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const StatusCard('3.1 운동', '130', '1'),
            const StatusCard('훈민정음', '70', '3'),
          ],
        ),
      ),
    );
  }
}
