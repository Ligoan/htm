import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ImagenTestScreen extends StatefulWidget {
  const ImagenTestScreen({super.key});

  @override
  ImagenTestScreenState createState() => ImagenTestScreenState();
}

class ImagenTestScreenState extends State<ImagenTestScreen> {
  String apiUrl = ''; // Remote Config에서 가져올 API URL
  String accessToken = ''; // Remote Config에서 가져올 토큰
  String? base64Image; // base64 인코딩된 이미지를 저장할 변수
  bool isLoading = false;
  // final TextEditingController _promptController =
  //     TextEditingController(); // 사용자 입력을 받을 텍스트 필드 컨트롤러

  @override
  void initState() {
    super.initState();
    fetchRemoteConfigValues(); // Remote Config 값 가져오기
  }

  Future<void> fetchRemoteConfigValues() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      // Firebase Remote Config 기본 설정
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      // Remote Config의 최신 값 가져오기
      await remoteConfig.fetchAndActivate();

      setState(() {
        apiUrl = remoteConfig.getString('apiUrl'); // API URL 가져오기
        accessToken =
            remoteConfig.getString('accessToken'); // Access Token 가져오기
        isLoading = false; // 로딩 완료
      });
    } catch (e) {
      print('Failed to fetch remote config: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Vertex AI API 호출하여 이미지 생성
  Future<void> generateImage() async {
    if (apiUrl.isEmpty || accessToken.isEmpty) {
      print('Missing API URL or access token.');
      return;
    } else {
      print(accessToken);
    }

    setState(() {
      isLoading = true; // 로딩 상태 표시
    });

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
              "prompt": "A portrait of a dog wearing a suit and tie."
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
