import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../components/category_card.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../models/wall_model.dart';


class AllCategoryScreen extends StatelessWidget {
  final List<String> categories;
  final List<String> categoryImagesUrl;
  final AsyncSnapshot<List<WallModel>> snapshotF;
  const AllCategoryScreen(
      {Key? key,
      required this.categories,
      required this.categoryImagesUrl,
      required this.snapshotF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
              toolbarHeight: 120,
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          textName: 'Categories',
                          fontSize: 32,
                          letterSpacing: -1,
                          textColor:
                              Theme.of(context).textTheme.labelLarge!.color,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          textName: 'Explore Categories',
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
                        Iconsax.category,
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
          body: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Entry.all(
                  delay: const Duration(milliseconds: 50),
                  child: CategoryCard(
                    categories: categories,
                    categoryImagesUrl: categoryImagesUrl,
                    index: index,
                    snapshotF: snapshotF,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
