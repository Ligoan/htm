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

    const String apiUrl =
        'https://us-central1-aiplatform.googleapis.com/v1/projects/his-toon-maker/locations/us-central1/publishers/google/models/imagen-3.0-generate-001:predict';
    const String accessToken =
        'ya29.a0AcM612wh8JaO_FwqUCO6iiFPQ_W_kz57FULu7okDjkkyfv15Hjn098JYkp8Gt_8zV1uZITs7zYvBxpsvUrkYfJYWq6Y-upQhiTAASZtQxj6_w8Bgea8BSvBd3FDIvfocQck6M6pgDd6345mVB6u0VN_EZBIwLC9ZdG61JLyYlsSUOQaCgYKAbwSARISFQHGX2Mie_3wNH6QdnR3_3VygBPeuA0181'; // gcloud auth를 통해 얻은 OAuth 2.0 토큰

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
            "prompt":
                "{'Topic': 'Portrait of the first Korean female aviator and independence activist.', 'Background': 'The background consists of a wide blue sky and a waving Korean flag, as if celebrating her achievements.', 'Situation': 'She is either sitting in the cockpit of an airplane or standing in front of a plane in a dignified pose.', 'Era': 'Retro style clothing and atmosphere from the early to mid-1900s when she was active.', 'Style': 'A style that combines realistic depiction with a touch of artistic flair. Vintage photo feel.', 'Other': 'She is wearing a flight suit, goggles, leather gloves, and a helmet. Her expression is confident and full of pride.  Short bobbed hair.', 'Atmosphere': 'Heroic, inspiring, and sublime atmosphere.'}" // 이미지 프롬프트
          }
        ],
        "parameters": {
          "sampleCount": 1 // 생성할 이미지 수
        }
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      setState(() {
        // 첫 번째 생성된 이미지의 base64 인코딩된 데이터를 가져옴
        base64Image = responseData['predictions'][0]['bytesBase64Encoded'];
        isLoading = false; // 로딩 완료
      });
    } else {
      print('Failed to generate image: ${response.statusCode}');
      print('Error: ${response.body}');
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
