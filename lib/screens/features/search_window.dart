import 'package:flutter/material.dart';

import '../summary_screen.dart';

class SearchWindow extends StatelessWidget {
  final _controller = TextEditingController();
  SearchWindow({super.key});

  void sendTextToSummaryPage(BuildContext context, String text) {
    if (text != "") {
      print("검색어: $text");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SummaryScreen(prompt: text),
        ),
      );
    } else {
      print("역사적 사실을 입력하지 않음.");
      // 테스트
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 8.0,
        right: 8.0,
      ),
      child: TextField(
        onTapOutside: (e) => FocusScope.of(context).unfocus(),
        onSubmitted: (text) => sendTextToSummaryPage(context, text),
        controller: _controller,
        style: const TextStyle(
          fontSize: 15.0,
        ),
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.clear),
          labelText: "검색",
          hintText: "역사적인 사건이나 인물을 입력하세요.",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
