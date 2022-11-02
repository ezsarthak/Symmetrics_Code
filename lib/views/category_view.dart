import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_symmetrics/screens/category_wall_screen.dart';
import 'package:main_symmetrics/utils/extensions.dart';
import '../components/custom_text.dart';
import '../models/wall_model.dart';
import '../screens/all_category_screen.dart';

class CategoryView extends StatelessWidget {
  final List<String> categories;
  final List<String> categoryImagesUrl;
  final AsyncSnapshot<List<WallModel>> snapshotF;

  const CategoryView(
      {Key? key,
      required this.categories,
      required this.categoryImagesUrl,
      required this.snapshotF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                textName: 'Categories',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textColor: Theme.of(context).textTheme.labelLarge!.color,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return AllCategoryScreen(
                      categories: categories,
                      categoryImagesUrl: categoryImagesUrl,
                      snapshotF: snapshotF,
                    );
                  }));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: CustomText(
                  textName: 'See All',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  textColor: Theme.of(context).textTheme.labelMedium!.color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 0),
        LimitedBox(
          // maxWidth: MediaQuery.of(context).size.width *  0.7,
          maxHeight: MediaQuery.of(context).size.height * 0.23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 16, right: 12),
            clipBehavior: Clip.none,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var snapshotCategory = snapshotF.data!.where((element) =>
                  (element.category.toString() ==
                          categories.elementAt(index).toString() &&
                      element.banner == 0));
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => CategoryWallsScreen(
                                selectedCategoryName:
                                    categories.elementAt(index),
                                snapshotC: snapshotF,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 4),
                  child: Container(
                    width: MediaQuery.of(context).size.width *  0.42,
                    height: MediaQuery.of(context).size.height * 0.23,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              width: double.infinity,
                              progressIndicatorBuilder: (context, url,   progress) =>  Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 6,
                                    value: progress.progress,
                                    color: Theme.of(context).textTheme.labelLarge!.color,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                              fit: BoxFit.cover,
                              imageUrl: categoryImagesUrl.elementAt(index),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                textName: categories
                                    .elementAt(index)
                                    .capitalizeFirstOfEach,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .color,
                                fontSize: 12,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w800,
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                textName: "${snapshotCategory.length} Walls",
                                textColor: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color,
                                fontSize: 8,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
