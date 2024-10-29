import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:main_symmetrics/components/custom_settings_tile.dart';
import 'package:main_symmetrics/components/settings_panel.dart';
import 'package:main_symmetrics/components/snackbar.dart';
import 'package:main_symmetrics/constants/dimensions.dart';
import 'package:main_symmetrics/screens/about_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../utils/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
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
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColorDark,

              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Theme.of(context).brightness,
              ),
              // expandedHeight: 300,
              pinned: false,
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Entry.all(
              //     delay: const Duration(milliseconds: 20),
              //     child: Container(
              //       decoration: const BoxDecoration(
              //           color: AppColors.secondary,
              //           borderRadius: BorderRadius.only(
              //               bottomRight: Radius.circular(20),
              //               bottomLeft: Radius.circular(20))),
              //       child: Padding(
              //         padding: const EdgeInsets.only(top: 130),
              //         child: Column(
              //           children: [
              //             Container(
              //               width: 300,
              //               height: 150,
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: AppColors.primaryLight, width: 2),
              //                   borderRadius: BorderRadius.circular(10)),
              //               alignment: Alignment.center,
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                 children: [
              //                   Container(
              //                     height: 100,
              //                     width: 100,
              //                     decoration: BoxDecoration(
              //                         border: Border.all(
              //                             color: AppColors.primaryLight
              //                                 .withOpacity(0.5),
              //                             width: 1.5),
              //                         borderRadius: BorderRadius.circular(12)),
              //                   ),
              //                   Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: const [
              //                       CustomText(
              //                         textName: "Symmetrics",
              //                         fontSize: 24,
              //                         letterSpacing: 1,
              //                         textColor: AppColors.primaryLight,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                       SizedBox(
              //                         height: 8,
              //                       ),
              //                       CustomText(
              //                         textName: "Handmade Walls",
              //                         fontSize: 16,
              //                         textColor: AppColors.primaryLight,
              //                         fontWeight: FontWeight.w500,
              //                       )
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              //   centerTitle: true,
              // ),
              floating: true,
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
                        Iconsax.arrow_left_1,
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
                          textName: 'Settings',
                          fontSize: 32,
                          letterSpacing: -1,
                          textColor:
                              Theme.of(context).textTheme.labelLarge!.color,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          textName: 'Change App Preferences',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          textColor:
                              Theme.of(context).textTheme.labelMedium!.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                SettingsPanel(panelName: 'UI', items: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                          borderRadius: Dimensions.smallCornerRadius,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.11,
                              vertical: 25),
                          backgroundColor: themeChange.darkTheme
                              ? Theme.of(context).cardColor
                              : Theme.of(context).indicatorColor,
                          onPressed: () {
                            themeChange.darkTheme = false;
                          },
                          buttonContent: CustomText(
                            textName: "Light",
                            textColor: Theme.of(context).hintColor,
                            fontSize: 20,
                          )),
                      CustomButton(
                          borderRadius: Dimensions.smallCornerRadius,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.11,
                              vertical: 25),
                          backgroundColor: themeChange.darkTheme
                              ? Theme.of(context).indicatorColor
                              : Theme.of(context).cardColor,
                          onPressed: () {
                            themeChange.darkTheme = true;
                          },
                          buttonContent: CustomText(
                            fontSize: 20,
                            textColor:
                                Theme.of(context).textTheme.labelLarge!.color,
                            textName: "Dark",
                          ))
                    ],
                  )
                ]),
                SettingsPanel(
                  panelName: 'About Us',
                  items: [
                    CustomSettingsTile(
                      title: 'Know More',
                      subtitle: 'via Twitter, Telegram',
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: ((context) => const AboutScreen()))),
                      trailing: CustomButton(
                        backgroundColor: Colors.transparent,
                        // padding: const EdgeInsets.all(10),
                        buttonContent: Icon(
                          Iconsax.send_2,
                          size: 32,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                SettingsPanel(
                  panelName: 'Storage',
                  items: [
                    CustomSettingsTile(
                      title: 'Clear Cache',
                      trailing: CustomButton(
                        backgroundColor: Colors.transparent,
                        // padding: const EdgeInsets.all(10),
                        buttonContent: Icon(
                          Iconsax.trash,
                          size: 30,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                        ),
                      ),
                      onTap: () {
                        DefaultCacheManager().emptyCache();
                        imageCache.clear();
                        imageCache.clearLiveImages();
                        setState(() {});
                        getSnackBar(context, "Cache Cleared");
                      },
                    ),
                  ],
                ),
                SettingsPanel(panelName: "Feedback", items: [
                  CustomSettingsTile(
                    title: "Rate App",
                    trailing: CustomButton(
                      backgroundColor: Colors.transparent,
                      // padding: const EdgeInsets.all(10),
                      buttonContent: Icon(
                        Iconsax.like,
                        size: 30,
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                      ),
                    ),
                    onTap: () async {
                      String uri =
                          'https://play.google.com/store/apps/details?id=dev.sarthak.symmetrics&hl=en-US&ah=PulkBdlLgWInFlz21YErqShEXLI';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        getSnackBar(context, "No Browser found");
                        print("No Browser found");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomSettingsTile(
                    title: "Report Bug",
                    trailing: CustomButton(
                      backgroundColor: Colors.transparent,
                      // padding: const EdgeInsets.all(10),
                      buttonContent: Icon(
                        Iconsax.danger,
                        size: 30,
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                      ),
                    ),
                    onTap: () async {
                      const String subject = "Report Bug For Symmectrics";
                      const String stringText =
                          "Enter Details Of Bug Here And Send";
                      String uri =
                          'mailto:thesarthakdesigns@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        getSnackBar(context, "No email client found");
                        print("No email client found");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomSettingsTile(
                    title: "Suggestions For Us",
                    trailing: CustomButton(
                      backgroundColor: Colors.transparent,
                      // padding: const EdgeInsets.all(10),
                      buttonContent: Icon(
                        Iconsax.add_square,
                        size: 30,
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                      ),
                    ),
                    onTap: () async {
                      const String subject = "Suggestions For Symmectrics";
                      const String stringText =
                          "Enter Details Of Your Suggestions, Feel Free To Send";
                      String uri =
                          'mailto:thesarthakdesigns@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        getSnackBar(context, "No email client found");
                        print("No email client found");
                      }
                    },
                  ),
                ]),
                SettingsPanel(panelName: "Other", paddingBottom: 12, items: [
                  CustomSettingsTile(
                    title: "Disclaimer",
                    trailing: CustomButton(
                      backgroundColor: Colors.transparent,
                      // padding: const EdgeInsets.all(10),
                      buttonContent: Icon(
                        Iconsax.warning_2,
                        size: 30,
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                      ),
                    ),
                    onTap: () {
                      disclaimerDialog(context);
                    },
                  )
                ]),
                // const SizedBox(
                //   height: 6,
                // ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.only(bottom: 24),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.labelMedium!.color),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.smallCornerRadius)),
                  alignment: Alignment.topLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomButton(
                                backgroundColor:
                                    Theme.of(context).indicatorColor,
                                borderRadius: Dimensions.smallCornerRadius,
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                buttonContent: CustomText(
                                  textName: "Information",
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color,
                                )),
                            CustomButton(
                              backgroundColor: Colors.transparent,
                              borderRadius: Dimensions.smallCornerRadius,
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              buttonContent: CustomText(
                                textName: "V 1.0.0",
                                fontSize: 14,
                                softWrap: true,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color,
                              ),
                            )
                          ],
                        ),
                        CustomText(
                          maxLines: 2,
                          textName:
                              "Made with love from india 🇮🇳 by Sarthak Patil..",
                          fontSize: 12,
                          letterSpacing: 1,
                          softWrap: true,
                          textColor:
                              Theme.of(context).textTheme.titleMedium?.color,
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void disclaimerDialog(BuildContext context) {
    var dialog = AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: CustomText(
        textName: "Disclaimer",
        fontSize: 20,
        textColor: Theme.of(context).textTheme.labelLarge!.color,
        fontWeight: FontWeight.bold,
      ),
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
                fontWeight: FontWeight.w500,
                maxLines: 10,
                textColor: Theme.of(context).textTheme.labelMedium!.color,
                textName:
                    "Wallpapers Are For Personal Use Only. For Commercial Give Us Proper Credit. Sharing Of This Wallpapers Not Allowed"),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                      borderRadius: BorderRadius.circular(40)),
                  child: Center(
                    child: CustomText(
                      textName: "OK",
                      textColor: Theme.of(context).textTheme.titleLarge!.color,
                      fontSize: 17,
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
}
