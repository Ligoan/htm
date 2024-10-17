import '/helper/global.dart';
import '/widgets/custom_btn.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/image_controller.dart';
import '../../widgets/custom_loading.dart';

class ImageCreatorFeature extends StatefulWidget {
  const ImageCreatorFeature({super.key});

  @override
  State<ImageCreatorFeature> createState() => _ImageCreatorFeatureState();
}

class _ImageCreatorFeatureState extends State<ImageCreatorFeature> {
  final _c = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text(
          'AI Image Creator',
        ),

        // share btn
        actions: [
          Obx(
            () => _c.status.value == Status.complete
                ? IconButton(
                    padding: const EdgeInsets.only(right: 6),
                    onPressed: _c.shareImage,
                    icon: const Icon(Icons.share),
                  )
                : const SizedBox(),
          ),
        ],
      ),

      // download btn
      floatingActionButton: Obx(
        () => _c.status.value == Status.complete
            ? Padding(
                padding: const EdgeInsets.only(
                  right: 6,
                  bottom: 6,
                ),
                child: FloatingActionButton(
                  onPressed: _c.downloadImage,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: const Icon(
                    Icons.save_alt_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              )
            : const SizedBox(),
      ),

      // body
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mq.height * .02,
          bottom: mq.height * .1,
          left: mq.width * 0.04,
          right: mq.width * .04,
        ),
        children: [
          // text field
          TextFormField(
            controller: _c.textC,
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: const InputDecoration(
              hintText:
                  'Imagine something wonderful & innovative\nType here & I will create for you😊',
              hintStyle: TextStyle(fontSize: 13.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),

          // ai image
          Container(
            height: mq.height * .5,
            alignment: Alignment.center,
            child: Obx(() => _aiImage()),
          ),

          // create btn
          CustomBtn(
            onTap: _c.createAIImage,
            text: 'Create',
          )
        ],
      ),
    );
  }

  Widget _aiImage() => ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: switch (_c.status.value) {
          Status.none => Lottie.asset(
              'assets/lottie/ai_play.json',
              height: mq.height * .4,
            ),
          Status.complete => CachedNetworkImage(
              imageUrl: _c.url,
              placeholder: (context, url) => const CustomLoading(),
              errorWidget: (context, url, error) => const SizedBox(),
            ),
          Status.loading => const CustomLoading(),
        },
      );
}
