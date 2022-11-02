import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../screens/settings_screen.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../models/wall_model.dart';
import '../views/category_view.dart';
import '../views/special_walls_view.dart';
import '../views/swiper_carousel.dart';

class HomeScreen extends StatefulWidget {
  final AsyncSnapshot<List<WallModel>> snapshotH;
  final ScrollController controller;
  const HomeScreen(
      {Key? key, required this.snapshotH, required this.controller})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [];
  List<String> categoryImagesUrl = [];

  @override
  void initState() {
    widget.snapshotH.data?.forEach((element) {
      if (!categories.contains(element.category) && element.banner == 0) {
        categories.add(element.category!);
        categoryImagesUrl.add(element.url!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      controller: widget.controller,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).primaryColorLight,
              Theme.of(context).backgroundColor,
            ],
          ),
        ),
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innnerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              automaticallyImplyLeading: false,
              floating: true,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Theme.of(context).brightness,
              ),
              toolbarHeight: 80,
              titleSpacing: 0,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          textName: 'Welcome',
                          fontSize: 32,
                          letterSpacing: -1,
                          textColor:
                              Theme.of(context).textTheme.labelLarge!.color,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          textName: 'Explore beautiful wallpapers',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          textColor:
                              Theme.of(context).textTheme.labelMedium!.color,
                        ),
                      ],
                    ),
                    CustomButton(
                      backgroundColor: Theme.of(context).cardColor,
                      // padding: const EdgeInsets.all(10),
                      buttonContent: Icon(
                        Iconsax.setting_34,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const SettingsScreen()));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
          body: ListView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            // controller: widget.controller,
            shrinkWrap: true,
            dragStartBehavior: DragStartBehavior.down,
            children: [
              Entry.all(
                  delay: const Duration(milliseconds: 20),
                  child: SwiperCarousel(snapshot: widget.snapshotH)),
              const SizedBox(height: 30),
              Entry.all(
                delay: const Duration(milliseconds: 20),
                child: CategoryView(
                  categoryImagesUrl: categoryImagesUrl,
                  categories: categories,
                  snapshotF: widget.snapshotH,
                ),
              ),
              const SizedBox(height: 30),
              Entry.all(
                delay: const Duration(milliseconds: 20),
                child: SpecialWallsView(
                  snapshotA: widget.snapshotH,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// const Icon(
// Iconsax.home,
// size: 32,
// color: Colors.black,
// ),
// CustomButton(
// backgroundColor: Colors.grey.shade100,
// buttonContent: const Icon(
// Iconsax.home,
// size: 28,
// color: Colors.black,
// ),
// ),

// Row(
// children: [
// CustomButton(
// backgroundColor: Colors.grey.shade100,
// buttonContent: const Icon(
// FeatherIcons.menu,
// size: 20,
// color: Colors.black,
// ),
// ),
// const SizedBox(width: 12),
// // const Text(
// //   'Symmetrics',
// //   style: TextStyle(
// //     fontFamily: 'Avenir',
// //     fontWeight: FontWeight.w900,
// //     fontSize: 28,
// //     color: Colors.black,
// //   ),
// // ),
//
// const CustomText(
// textName: 'Symmetrics',
// fontSize: 34,
// fontWeight: FontWeight.w900,
// letterSpacing: -0.8,
// ),
// ],
// ),
// CustomButton(
// backgroundColor: Colors.grey.shade100,
// buttonContent: const Icon(
// FeatherIcons.bell,
// size: 20,
// color: Colors.black,
// ),
// ),
