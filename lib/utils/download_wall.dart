import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../components/custom_text.dart';
import '../constants/app_colors.dart';

Future downloadWallpaper(
  BuildContext context,
  String imageUrl,
  Color bg,
  Color accent,
) async {
  var status = await Permission.storage.request();

  if (status.isGranted) {
    try {
      // Download the image data
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;

        // Save to gallery
        final result = await ImageGallerySaverPlus.saveImage(bytes);

        print('Image saved: $result');
        showSnackbar(context, bg, accent);
      }
    } on PlatformException catch (error) {
      print(error);
    }
  } else {
    _showOpenSettingsAlert(context);
  }
}

void _showOpenSettingsAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Need access to storage.'),
        actions: [
          TextButton(
            onPressed: () {
              openAppSettings();
            },
            child: const Text('Open settings'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          )
        ],
      );
    },
  );
}

void showSnackbar(BuildContext context, Color bg, Color accent) {
  var dialog = AlertDialog(
    backgroundColor: bg.withOpacity(0.7),
    // title: CustomText(
    //   textName: "Disclaimer",
    //   fontSize: 20,
    //   textColor: Theme.of(context).textTheme.labelLarge!.color,
    //   fontWeight: FontWeight.bold,
    // ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
    ),
    content: SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              maxLines: 10,
              textColor: accent,
              textName: "Download Successful"),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Container(
                height: 70,
                width: 120,
                decoration: BoxDecoration(
                    color: bg, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: CustomText(
                    textName: "OKAY",
                    textColor: accent,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => dialog);
}
// Future<void> downloadImageToPictures(String imageUrl) async {
//   if (await Permission.storage.request().isGranted) {
//     try {
//       // Download the image data
//       final response = await http.get(Uri.parse(imageUrl));
//
//       if (response.statusCode == 200) {
//         final Uint8List bytes = response.bodyBytes;
//
//         // Save to gallery
//
//         print('Image saved: $result');
//       } else {
//         print('Failed to download image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error saving image: $e');
//     }
//   } else {
//     print('Permission denied');
//   }
// }
