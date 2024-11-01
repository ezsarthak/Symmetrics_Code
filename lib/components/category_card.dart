import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/custom_text.dart';
import '../models/wall_model.dart';
import '../screens/category_wall_screen.dart';

class CategoryCard extends StatelessWidget {
  final List<String> categories;
  final List<String> categoryImagesUrl;
  final AsyncSnapshot<List<WallModel>> snapshotF;
  final int index;
  const CategoryCard({
    Key? key,
    required this.categories,
    required this.categoryImagesUrl,
    required this.snapshotF,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => CategoryWallsScreen(
                        selectedCategoryName: categories.elementAt(index),
                        snapshotC: snapshotF,
                      )));
        },
        child: Stack(
          children: [
            CachedNetworkImage(
                filterQuality: FilterQuality.low,
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
                fit: BoxFit.contain,
                imageUrl: categoryImagesUrl.elementAt(index),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColorDark,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        // border: Border.all(
                        //   color: Theme.of(context).primaryColorDark,
                        // ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      alignment: Alignment.bottomLeft,
                      child: CustomText(
                        textName: categories.elementAt(index).toUpperCase(),
                        fontSize: 32,
                        letterSpacing: 4,
                        textColor: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
