import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../components/wall_card.dart';
import '../models/wall_model.dart';

class AllWallsScreen extends StatefulWidget {
  final AsyncSnapshot<List<WallModel>> snapshotA;
  final ScrollController controller;

  const AllWallsScreen(
      {Key? key, required this.snapshotA, required this.controller})
      : super(key: key);

  @override
  State<AllWallsScreen> createState() => _AllWallsScreenState();
}

class _AllWallsScreenState extends State<AllWallsScreen> {
  List<WallModel> snapshotNew = [];
  @override
  void initState() {
    widget.snapshotA.data!.forEach((element) {
      if (element.banner == 0) {
        snapshotNew.add(element);
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
              toolbarHeight: 120,
              titleSpacing: 0,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          textName: 'Wallpapers',
                          fontSize: 32,
                          letterSpacing: -1,
                          textColor:
                              Theme.of(context).textTheme.labelLarge!.color,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          textName: 'All Wallpapers',
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
                        Iconsax.gallery,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                      // onPressed: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => const SettingsScreen()));
                      // },
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: StaggeredGridView.countBuilder(
              // scrollDirection: Axis.vertical,
              // controller: widget.controller,
              // physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: snapshotNew.length,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              addRepaintBoundaries: true,
              staggeredTileBuilder: (index) => const StaggeredTile.count(2, 3),
              crossAxisCount: 4,
              itemBuilder: (context, index) {
                return Entry.all(
                  delay: const Duration(milliseconds: 20),
                  child: WallCard(
                    index: index,
                    currentWall: snapshotNew.elementAt(index),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
