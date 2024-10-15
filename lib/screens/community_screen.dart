import 'package:flutter/material.dart';
import 'package:myapp/widgets/ranking_card.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        centerTitle: true,
        title: const Text('커뮤니티'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/mypage'); // 프로필 페이지로 이동
            },
          ),
        ],
      ),

      // Body
      body: ListView(
        children: [
          // 웹툰 랭킹
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '웹툰 랭킹',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildRankingsGrid([
            const RankingCard(1, '임진왜란', 'assets/images/toon1.png', 100, 5, 15),
            const RankingCard(
                2, '3.1 운동', 'assets/images/toon2.png', 80, 6, 10),
            // RankingCard(3, '순교성지', 'assets/sungyo.png', 70, 4, 12),
            // RankingCard(4, '조선왕조실록', 'assets/joseon.png', 90, 3, 14),
            // RankingCard(5, '울산 암각화', 'assets/ulsan.png', 130, 2, 20),
          ]),

          // 이미지 요약 랭킹
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '이미지 요약 랭킹',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildRankingsGrid([
            const RankingCard(
                1, '3.1 운동', 'assets/images/banner_image.png', 130, 5, 20),
            const RankingCard(
                2, '6.25 전쟁', 'assets/images/625.png', 100, 6, 12),
          ]),
        ],
      ),
    );
  }

  // 랭킹 그리드 빌드
  Widget _buildRankingsGrid(List<Widget> rankingCards) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(), // 내장 스크롤 비활성화
        shrinkWrap: true,
        crossAxisCount: 2, // 두 개의 열로 나누기
        childAspectRatio: 0.8, // 카드의 세로 비율 조정
        children: rankingCards,
      ),
    );
  }
}
