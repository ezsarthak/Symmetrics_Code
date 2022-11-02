import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:main_symmetrics/components/custom_text.dart';
import 'package:main_symmetrics/components/snackbar.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

enum SetWallpaperAs { home, lock, both }

const _setAs = {
  SetWallpaperAs.home: WallpaperManagerFlutter.HOME_SCREEN,
  SetWallpaperAs.lock: WallpaperManagerFlutter.LOCK_SCREEN,
  SetWallpaperAs.both: WallpaperManagerFlutter.BOTH_SCREENS,
};

Future<void> setWallpaper({
  required BuildContext context,
  required String imgUrl,
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
      context: context, builder: (context) => actionSheet);

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
        await WallpaperManagerFlutter()
            .setwallpaperfromFile(croppedImg, _setAs[option]);
        getSnackBar(context, "Set Successful");
        // if (result != null) {
        //   debugPrint(result);
        // }
      }
    }
  }
}
