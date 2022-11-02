import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:main_symmetrics/screens/all_wall_screen.dart';
import 'package:main_symmetrics/screens/favourites_screen.dart';
import '../constants/app_colors.dart';
import '../models/wall_model.dart';
import '../utils/scroll_to_hide.dart';
import 'home_screen.dart';

class NavBarScreen extends StatefulWidget {
  final AsyncSnapshot<List<WallModel>> snapshot;

  const NavBarScreen({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  late ScrollController controller;

  /// variables
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    final pages = [
      HomeScreen(
        snapshotH: widget.snapshot,
        controller: controller,
      ),
      AllWallsScreen(
        snapshotA: widget.snapshot,
        controller: controller,
      ),
      // FavouritesScreen(
      //   snapshotF: snapshot,
      // ),
      FavouritesScreen(
        snapshotF: widget.snapshot,
        controller: controller,
      ),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).primaryColorDark,
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        controller: pageController,
          onPageChanged: (int newIndex){
            setState(() {
              _currentIndex = newIndex;
            });
          },
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
        return pages[index];

      }),
      bottomNavigationBar: ScrollToHideWidget(
        controller: controller,
        child: CustomNavigationBar(
          scaleFactor: 0.3,
          strokeColor: Theme.of(context).indicatorColor,
          iconSize: 28,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedColor: Colors.white,
          unSelectedColor: AppColors.secondaryLight.withOpacity(0.32),
          isFloating: true,
          currentIndex: _currentIndex,
          scaleCurve: Curves.bounceOut,
          bubbleCurve: Curves.easeInOut,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
              pageController.animateToPage(newIndex, duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
            });
          },
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Iconsax.home),
            ),
            CustomNavigationBarItem(icon: const Icon(Iconsax.gallery)),
            CustomNavigationBarItem(icon: const Icon(Iconsax.heart)),
          ],
        ),
      ),
    );
  }
}
