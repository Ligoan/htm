import 'dart:developer';
import 'dart:io';

import '/helper/my_dialog.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '/helper/global.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();

  final status = Status.none.obs;

  String url = '';

  Future<void> createAIImage() async {
    if (textC.text.trim().isNotEmpty) {
      OpenAI.apiKey = apiKey;
      status.value = Status.loading;
      OpenAIImageModel image = await OpenAI.instance.image.create(
        model: 'dall-e-3',
        prompt:
            """{'Topic': "Depict the March 1st Movement, a peaceful protest demanding Korea's independence on March 1, 1919.", 'Background': 'Show the street scenes of Korea during the March 1st Movement, with crowds starting from Pagoda Park in Seoul and spreading nationwide. Dynamically depict people participating in the Manse Demonstrations, waving Korean flags, and resisting Japanese police.', 'Era': '1910s Japanese colonial period', 'Style': 'Realistic and historical photograph style', 'Other': "Protesters are wearing traditional Korean clothing of that time. The crowd includes people from various social classes, such as students, farmers, laborers, and women. Japanese police officers are depicted in uniform and carrying weapons. The crowd shouts 'Daehan Doknip Manse' (Long live Korean independence), and Korean flags are waving everywhere.", 'Mood': 'Solemn, hopeful, and tense atmosphere'}. seednumber:5468132547d""",
        //prompt: textC.text,
        n: 1,
        size: OpenAIImageSize.size1024,
        responseFormat: OpenAIImageResponseFormat.url,
      );

      url = image.data[0].url.toString();

      status.value = Status.complete;
    } else {
      MyDialog.info('Provide some beautiful image description!');
    }
  }

  void downloadImage() async {
    try {
      // to show loading
      MyDialog.showLoadingDialog();

      log('url: $url');

      final bytes = (await get(Uri.parse(url))).bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      log('filePath: ${file.path}');

      // save image to gallery
      await GallerySaver.saveImage(
        file.path,
        albumName: appName,
      ).then((success) {
        // hide loading
        Get.back();
        MyDialog.success('Image Downloaded to Gallery!');
      });
    } catch (e) {
      // hide loading
      Get.back();
      MyDialog.error('Something Went Wrong ( Try again in sometime )!');
      log('downloadImageE: $e');
    }
  }

  void shareImage() async {
    try {
      // to show loading
      MyDialog.showLoadingDialog();

      log('url: $url');

      final bytes = (await get(Uri.parse(url))).bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      log('filePath: ${file.path}');

      // hide loading
      Get.back();

      await Share.shareXFiles([XFile(file.path)],
          text:
              'Check out this Amazing Image created by AI Assistant App by HTML');
    } catch (e) {
      // hide loading
      Get.back();
      MyDialog.error('Something Went Wrong ( Try again in sometime )!');
      log('downloadImageE: $e');
    }
  }
}
