import 'package:flutter/material.dart';

// 랭킹 카드 위젯 (ranking 번호 추가)

class RankingCard extends StatelessWidget {
  final int rank;
  final String title;
  final String imagePath;
  final int likes;
  final int dislikes;
  final int comments;
  const RankingCard(this.rank, this.title, this.imagePath, this.likes,
      this.dislikes, this.comments,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'No.$rank ', // Bold and larger part
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18, // Larger font size
                        ),
                      ),
                      TextSpan(
                        text: title, // Regular part
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.thumb_up, size: 16),
                    const SizedBox(width: 4),
                    Text('$likes'),
                    const SizedBox(width: 16),
                    const Icon(Icons.thumb_down, size: 16),
                    const SizedBox(width: 4),
                    Text('$dislikes'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.comment, size: 16),
                    Text('$comments comments'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
