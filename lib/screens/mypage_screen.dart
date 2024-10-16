import 'package:flutter/material.dart';

import '../widgets/status_card.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> listFiles() async {
  try {
    Reference folderRef = FirebaseStorage.instance.ref();
    ListResult result = await folderRef.listAll();
    List<String> names = result.items.map((Reference ref) => ref.name).toList();
    print(names);

    // Firebase Storage의 지정된 경로를 참조합니다.
    // Reference storageRef = FirebaseStorage.instance.ref().child();

    // // 해당 경로 내 모든 파일 및 폴더를 가져옵니다.
    // ListResult result = await storageRef.listAll();

    // // 폴더 목록 출력
    // result.prefixes.forEach((Reference folderRef) {
    //   print('Folder: ${folderRef.fullPath}');
    // });

    // // 파일 목록 출력
    // result.items.forEach((Reference fileRef) {
    //   print('File: ${fileRef.fullPath}');
    // });
  } catch (e) {
    print('Error occurred while listing files: $e');
  }
}

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
                      // if (FirebaseAuth.instance.currentUser == null) {
                      //   // 사용자가 로그인되어 있지 않음
                      //   // 여기서 로그인 절차를 처리
                      //   print("sss");
                      // } else {
                      // 사용자가 로그인되어 있음, 요청을 계속 진행
                      listFiles();
                      // }

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
