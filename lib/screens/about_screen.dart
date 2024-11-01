import 'package:cached_network_image/cached_network_image.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../components/custom_settings_tile.dart';
import '../components/custom_text.dart';
import '../components/settings_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/custom_button.dart';
import '../components/snackbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Theme.of(context).brightness,
        ),
        toolbarHeight: 120,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomButton(
                backgroundColor: Theme.of(context).cardColor,
                // padding: const EdgeInsets.all(10),
                buttonContent: Icon(
                  Iconsax.backward,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textName: 'About Us',
                    fontSize: 30,
                    letterSpacing: -1,
                    textColor: Theme.of(context).textTheme.labelLarge!.color,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    textName: 'Know More',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    textColor: Theme.of(context).textTheme.labelMedium!.color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).primaryColorLight,
              Theme.of(context).canvasColor,
            ],
            // Colors.amber.shade100,
          ),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          clipBehavior: Clip.none,
          padding: const EdgeInsets.only(left: 18, right: 18),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Container(
                //   height: MediaQuery.of(context).size.width * 0.7,
                //   width: MediaQuery.of(context).size.width * 0.7,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(16),
                //       image: const DecorationImage(
                //           image: AssetImage("assets/prf_pic.jpg"))),
                // ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage("assets/prf_pic.jpg"),
                  radius: MediaQuery.of(context).size.width * 0.32,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomText(
                  textName: "Sarthak Patil",
                  fontSize: 28,
                  textColor: Theme.of(context).textTheme.labelLarge!.color,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 48,
                ),
                Entry.all(
                  delay: const Duration(milliseconds: 20),
                  child: GestureDetector(
                    onTap: () async {
                      String uri = 'https://linkedin.com/in/sarthaknpatil';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        getSnackBar(context, "No Browser found");
                        print("No Browser found");
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/Linkedin.png"))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Entry.all(
                  delay: const Duration(milliseconds: 20),
                  child: GestureDetector(
                    onTap: () async {
                      String uri = 'https://x.com/ezsarthak';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        getSnackBar(context, "No Browser found");
                        print("No Browser found");
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/Twitter.png"))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Entry.all(
                  delay: const Duration(milliseconds: 20),
                  child: GestureDetector(
                    onTap: () async {
                      String uri = 'https://github.com/ezsarthak';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        getSnackBar(context, "No Browser found");
                        print("No Browser found");
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage("assets/Github.png"))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//  SingleChildScrollView(
//   scrollDirection: Axis.vertical,
//   physics: const BouncingScrollPhysics(),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Center(
//         child: CircleAvatar(
//           radius: 80,
//           backgroundColor: Colors.transparent,
//           backgroundImage: NetworkImage(url),
//         ),
//       ),
//       Center(
//         child: Text(
//           "Sarthak Designs",
//           style: GoogleFonts.poppins(
//               textStyle: const TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.bold)),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(
//           left: 10.0,
//         ),
//         child: Text(
//           "Developers -",
//           style: GoogleFonts.poppins(
//               textStyle: const TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.bold)),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(top: 10),
//         child: Container(
//           height: 130,
//           width: MediaQuery.of(context).size.width,
//           margin: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(20)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 18),
//                 child: ListTile(
//                   title: Text(
//                     "Sarthak Patil",
//                     style: GoogleFonts.poppins(
//                         textStyle: const TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.bold)),
//                   ),
//                   subtitle: Text(
//                     "App Dev And Wallpaper Designer",
//                     style: GoogleFonts.poppins(
//                         textStyle: const TextStyle(
//                             fontSize: 10, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Row(
//                   children: const [
//                     Icon(Icons.telegram),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
