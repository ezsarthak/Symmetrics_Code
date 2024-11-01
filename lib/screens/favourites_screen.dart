import 'package:cached_network_image/cached_network_image.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../constants/constants.dart';
import '../models/wall_model.dart';
import '../utils/shared_preferences.dart';
import 'wall_detail_page_screen.dart';

removeItem(String toRemove) async {
  favoriteIds.remove(toRemove);
  await UserSimplePrefs.setFavoriteIDs(favoriteIds);
}

class FavouritesScreen extends StatefulWidget {
  final AsyncSnapshot<List<WallModel>> snapshotF;
  final ScrollController controller;

  const FavouritesScreen(
      {Key? key, required this.snapshotF, required this.controller})
      : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<WallModel> favoriteWalls = [];
  late Future<List<WallModel>> futureobj;
  @override
  void initState() {
    futureobj = futurefavwalls();
    super.initState();
  }

  Future<List<WallModel>> futurefavwalls() async {
    widget.snapshotF.data!.forEach((element) {
      if (favoriteIds.contains(element.id) && element.banner == 0) {
        favoriteWalls.add(element);
      }
    });
    return favoriteWalls;
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
              Theme.of(context).canvasColor,
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
                          textName: 'Favorites',
                          fontSize: 32,
                          letterSpacing: -1,
                          textColor:
                              Theme.of(context).textTheme.labelLarge!.color,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          textName: 'Explore Your Favorites',
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
                        Iconsax.heart,
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
          body: FutureBuilder(
            builder: (context, snapshot) {
              if (favoriteWalls.isEmpty) {
                return Center(
                  child: CustomText(
                    textName: "No Favorites",
                    textColor: Theme.of(context).textTheme.labelLarge!.color,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else if (favoriteWalls.isNotEmpty) {
                return StaggeredGridView.countBuilder(
                    crossAxisSpacing: 10,
                    // controller: widget.controller,
                    mainAxisSpacing: 10,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: favoriteWalls.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    addRepaintBoundaries: true,
                    staggeredTileBuilder: (index) =>
                        const StaggeredTile.count(2, 3),
                    crossAxisCount: 4,
                    itemBuilder: (context, index) {
                      return Entry.all(
                        delay: const Duration(milliseconds: 20),
                        child: Hero(
                          tag: favoriteWalls.elementAt(index).id!,
                          child: Material(
                            type: MaterialType.transparency,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WallDetailScreen(
                                              isswiper: false,
                                              herotag: favoriteWalls
                                                  .elementAt(index)
                                                  .id!,
                                              currentWall: favoriteWalls
                                                  .elementAt(index),
                                            )));
                              },
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    placeholder: (context, url) => Center(
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 5,
                                          color: Theme.of(context).cardColor,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        favoriteWalls.elementAt(index).url!,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.22,
                                                    child: CustomText(
                                                      textName: favoriteWalls
                                                          .elementAt(index)
                                                          .name!
                                                          .toUpperCase(),
                                                      softWrap: true,
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      // letterSpacing: -1,
                                                      textColor: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.18,
                                                    child: CustomText(
                                                      textName: favoriteWalls
                                                          .elementAt(index)
                                                          .category!
                                                          .toUpperCase(),
                                                      softWrap: true,
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11,
                                                      textColor: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              CustomButton(
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.12),
                                                borderRadius: 32,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                buttonContent: Icon(
                                                  favoriteIds.contains(
                                                          favoriteWalls
                                                              .elementAt(index)
                                                              .id)
                                                      ? Iconsax.heart5
                                                      : Iconsax.heart,
                                                  size: 22,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    setState(() {
                                                      removeItem(favoriteWalls
                                                          .elementAt(index)
                                                          .id!);
                                                      favoriteWalls.remove(
                                                          favoriteWalls
                                                              .elementAt(
                                                                  index));
                                                    });
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: futureobj.whenComplete(
                () => Future.delayed(const Duration(milliseconds: 700))),
          ),
        ),
      ),
    );
  }
}
