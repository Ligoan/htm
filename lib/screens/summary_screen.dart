import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '/utils/app_const.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SummaryScreen extends StatelessWidget {
  final String prompt;
  final model = GenerativeModel(
    model: geminiModelFlash,
    apiKey: apiKey,
  );

  SummaryScreen({
    super.key,
    required this.prompt,
  });

  Future<GenerateContentResponse> generateResponse() async {
    return await model.generateContent([Content.text(prompt)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text("사건 요약"),
        centerTitle: true,
      ),

      // Body
      body: FutureBuilder<GenerateContentResponse>(
        future: generateResponse(),
        builder: (context, snapshot) {
          // Gemini 응답을 기다릴 때
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );

            // 응답 결과가 에러일 때
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );

            // 응답 결과가 null일 때
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No data found.'),
            );
          } else {
            // 응답 결과가 정상일 때
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(10.0),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.90,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      MarkdownBody(
                        selectable: true,
                        data: snapshot.data!.text!,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('AI 이미지 1컷 생성'),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 15),
                          ElevatedButton(
                            child: const Text('AI 이미지 4컷 생성'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      ElevatedButton(
                        child: const Text('Dalle Test'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/dalle_test');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
