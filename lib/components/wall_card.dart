import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/constants.dart';
import '../models/wall_model.dart';
import '../screens/wall_detail_page_screen.dart';
import '../utils/shared_preferences.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class WallCard extends StatefulWidget {
  final WallModel currentWall;
  final int index;

  const WallCard({Key? key, required this.currentWall, required this.index})
      : super(key: key);

  @override
  State<WallCard> createState() => _WallCardState();
}

class _WallCardState extends State<WallCard> {
  void addItem(String toAdd) {
    favoriteIds.add(toAdd);
    UserSimplePrefs.setFavoriteIDs(favoriteIds);
  }

  void removeItem(String toRemove) {
    favoriteIds.remove(toRemove);
    UserSimplePrefs.setFavoriteIDs(favoriteIds);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.currentWall.id!,
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WallDetailScreen(
                          herotag: widget.currentWall.id!,
                          isswiper: false,
                          currentWall: widget.currentWall,
                        )));
          },
          child: Stack(
            children: [
              CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      value: progress.progress,
                      color: Theme.of(context).textTheme.labelLarge!.color,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
                imageUrl: widget.currentWall.thumb ?? widget.currentWall.url!,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Theme.of(context).primaryColorDark,
                      // ),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: CustomText(
                                  textName:
                                      widget.currentWall.name!.toUpperCase(),
                                  softWrap: true,
                                  textOverflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  // letterSpacing: -1,
                                  textColor: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: CustomText(
                                  textName: widget.currentWall.category!
                                      .toUpperCase(),
                                  softWrap: true,
                                  textOverflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  textColor: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          CustomButton(
                            backgroundColor: Colors.white.withOpacity(0.12),
                            borderRadius: 32,
                            padding: const EdgeInsets.all(8),
                            buttonContent: Icon(
                              favoriteIds.contains(widget.currentWall.id)
                                  ? Iconsax.heart5
                                  : Iconsax.heart,
                              size: 22,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                if (favoriteIds
                                    .contains(widget.currentWall.id)) {
                                  setState(() {
                                    removeItem(widget.currentWall.id!);
                                  });
                                } else {
                                  setState(() {
                                    addItem(widget.currentWall.id!);
                                  });
                                }
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
    );
  }
}

// Container(
// padding: const EdgeInsets.all(10),
// decoration: BoxDecoration(
// color: Colors.white.withOpacity(0.12),
// borderRadius: BorderRadius.circular(100.0),
// ),
// child: Icon(
// favoriteIds.contains(widget.currentWall.id)
// ? Icons.favorite
//     : Icons.favorite_border,
// color: Colors.red,
// size: 18,
// ),
// )
