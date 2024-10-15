import 'package:flutter/material.dart';

// 이벤트 카드 위젯
class EventCard extends StatelessWidget {
  final String title;
  final String? imagePath;

  const EventCard(this.title, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: imagePath != null
                ? Image.asset(
                    imagePath!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
