import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';
import '../components/custom_text.dart';
import '../components/snackbar.dart';

enum SetWallpaperAs { home, lock, both }

const _setAs = {
  SetWallpaperAs.home: WallpaperManagerPlus.homeScreen,
  SetWallpaperAs.lock: WallpaperManagerPlus.lockScreen,
  SetWallpaperAs.both: WallpaperManagerPlus.bothScreens,
};

Future<void> setWallpaper({
  required BuildContext context,
  required String imgUrl,
  required Color bg,
  required Color accent,
}) async {
  var actionSheet = CupertinoActionSheet(
    title: Center(
      child: CustomText(
        textName: 'Set as',
        textColor: Theme.of(context).textTheme.labelLarge!.color,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        letterSpacing: 3,
      ),
    ),
    actions: [
      CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(SetWallpaperAs.home);
          },
          child: CustomText(
            textName: 'Home Screen',
            textColor: Theme.of(context).textTheme.labelLarge!.color,
            fontSize: 15,
          )),
      CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(SetWallpaperAs.lock);
          },
          child: CustomText(
            textName: 'Lock Screen',
            textColor: Theme.of(context).textTheme.labelLarge!.color,
            fontSize: 15,
          )),
      CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(SetWallpaperAs.both);
          },
          child: CustomText(
            textName: 'Both Screens',
            textColor: Theme.of(context).textTheme.labelLarge!.color,
            fontSize: 15,
          )),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: CustomText(
        textName: 'Cancel',
        fontSize: 15,
        textColor: Theme.of(context).textTheme.labelLarge!.color,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );

  var option = await showCupertinoModalPopup(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) => actionSheet);

  if (option != null && option != "Cancel") {
    var cachedImg = await DefaultCacheManager().getSingleFile(imgUrl);

    if (cachedImg != null) {
      var croppedImg = await ImageCropper().cropImage(
        sourcePath: cachedImg.path,
        aspectRatio: CropAspectRatio(
          ratioX: MediaQuery.of(context).size.width,
          ratioY: MediaQuery.of(context).size.height,
        ),
        // androidUiSettings: const AndroidUiSettings(
        //   toolbarColor: Colors.blue,
        //   toolbarTitle: 'Crop Image',
        //   hideBottomControls: true,
        // ),
      );

      if (croppedImg != null) {
        File croppedFile = File(croppedImg.path);
        await WallpaperManagerPlus().setWallpaper(croppedFile, _setAs[option]!);
        // getSnackBar(context, "Set Successful");
        showSnackbar(context, bg, accent);
        // if (result != null) {
        //   debugPrint(result);
        // }
      }
    }
  }
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
              fontSize: 28,
              maxLines: 10,
              textColor: accent,
              textName: "Set Successful"),
          const SizedBox(
            height: 12,
          ),
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
