import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/category_wall_screen.dart';
import '../utils/extensions.dart';
import '../components/category_card.dart';
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
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 16, right: 12),
          clipBehavior: Clip.none,
          itemCount: 4,
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
                              selectedCategoryName: categories.elementAt(index),
                              snapshotC: snapshotF,
                            )));
              },
              child: CategoryCard(
                categories: categories,
                categoryImagesUrl: categoryImagesUrl,
                index: index,
                snapshotF: snapshotF,
              ),
            );
          },
        ),
      ],
    );
  }
}
