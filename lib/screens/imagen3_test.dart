import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImagenTestScreen extends StatefulWidget {
  const ImagenTestScreen({super.key});

  @override
  _ImagenTestScreenState createState() => _ImagenTestScreenState();
}

class _ImagenTestScreenState extends State<ImagenTestScreen> {
  String? base64Image; // base64 인코딩된 이미지를 저장할 변수
  bool isLoading = false;
  // final TextEditingController _promptController =
  //     TextEditingController(); // 사용자 입력을 받을 텍스트 필드 컨트롤러

  // Vertex AI API 호출하여 이미지 생성
  Future<void> generateImage() async {
    setState(() {
      isLoading = true; // 로딩 상태 표시
    });

    const String apiUrl = 'your-apiUrl';
    const String accessToken =
        'your-token-id'; // gcloud auth를 통해 얻은 OAuth 2.0 토큰
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "instances": [
            {
              // "prompt": prompt
              "prompt": "A portrait of a cat wearing a suit and tie."
            }
          ],
          "parameters": {
            "sampleCount": 1 // 생성할 이미지 수
          }
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // 응답 데이터 구조 검증
        if (responseData.containsKey('predictions') &&
            responseData['predictions'] != null &&
            responseData['predictions'].isNotEmpty) {
          setState(() {
            base64Image = responseData['predictions'][0]['bytesBase64Encoded'];
            isLoading = false; // 로딩 완료
          });
        } else {
          throw Exception('Invalid response structure: ${response.body}');
        }
      } else {
        throw Exception('Failed to generate image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // 로딩 완료
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagen3 Test Page'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() // 로딩 중일 때 표시
            : base64Image != null
                ? ImageDisplay(base64Image: base64Image!)
                : const Text(
                    'Press the button to generate an image.'), // 아직 이미지가 없을 때 표시
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: generateImage, // 고정된 프롬프트로 이미지 생성
        child: const Icon(Icons.image),
      ),
    );
  }
}

class ImageDisplay extends StatelessWidget {
  final String base64Image;

  const ImageDisplay({super.key, required this.base64Image});

  @override
  Widget build(BuildContext context) {
    // base64 인코딩된 이미지를 디코딩하여 메모리에서 이미지로 표시
    final decodedBytes = base64Decode(base64Image);

    return Image.memory(decodedBytes); // 디코딩된 이미지 표시
  }
}
