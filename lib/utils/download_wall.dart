// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_downloader/image_downloader.dart';
// import 'package:main_symmetrics/components/custom_text.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../constants/app_colors.dart';
//
// Future downloadWallpaper(BuildContext context, String imgUrl) async {
//   var status = await Permission.storage.request();
//
//   if (status.isGranted) {
//     try {
//       var imageId = await ImageDownloader.downloadImage(
//         imgUrl,
//         destination: AndroidDestinationType.directoryPictures,
//       );
//
//       ScaffoldMessenger.of(context)
//         ..removeCurrentSnackBar()
//         ..showSnackBar(
//           SnackBar(
//             backgroundColor:
//                 Theme.of(context).navigationBarTheme.backgroundColor,
//             content: const CustomText(
//               textName: 'Download completed.',
//               textColor: AppColors.secondaryLight,
//             ),
//             action: SnackBarAction(
//               label: 'Open',
//               textColor: AppColors.secondaryLight,
//               onPressed: () async {
//                 var path = await ImageDownloader.findPath(imageId!);
//                 await ImageDownloader.open(path!);
//               },
//             ),
//           ),
//         );
//     } on PlatformException catch (error) {
//       print(error);
//     }
//   } else {
//     _showOpenSettingsAlert(context);
//   }
// }
//
// void _showOpenSettingsAlert(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Need access to storage.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               openAppSettings();
//             },
//             child: const Text('Open settings'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           )
//         ],
//       );
//     },
//   );
// }
