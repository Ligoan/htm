import 'package:flutter/material.dart';

// 상태 카드

class StatusCard extends StatelessWidget {
  final String title, likes, rank;
  const StatusCard(this.title, this.likes, this.rank, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset('assets/images/image_placeholder.png',
                width: 50, height: 50), // 이미지 경로 설정
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.thumb_up, size: 16),
                      // Text('좋아요: $likes'),
                      Text(likes),
                      const SizedBox(width: 16),
                      // Icon(Icons.thumb_down, size: 16),
                      Text('No.  $rank'),
                      // Text('$rank'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
