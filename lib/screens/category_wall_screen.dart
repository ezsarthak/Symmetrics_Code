import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';
import '../components/custom_text.dart';
import '../utils/extensions.dart';
import '../components/custom_button.dart';
import '../components/wall_card.dart';
import '../main.dart';
import '../models/wall_model.dart';

class CategoryWallsScreen extends StatelessWidget {
  final String selectedCategoryName;
  final AsyncSnapshot<List<WallModel>> snapshotC;
  const CategoryWallsScreen(
      {Key? key, required this.selectedCategoryName, required this.snapshotC})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snapshotCategory = snapshotC.data!.where(
        (element) => (element.category == selectedCategoryName.toString()));
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innnerBoxIsScrolled) => [
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
                    width: 10,
                  ),
                  CustomText(
                    textName: selectedCategoryName.capitalizeFirstOfEach,
                    fontSize: 30,
                    letterSpacing: 2,
                    textColor: Theme.of(context).textTheme.labelLarge!.color,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomButton(
                    backgroundColor: Theme.of(context).cardColor,
                    // padding: const EdgeInsets.all(10),
                    buttonContent: CustomText(
                      textName: snapshotCategory.length.toString(),
                      textColor: Theme.of(context).textTheme.labelMedium!.color,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: StaggeredGridView.countBuilder(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshotCategory.length,
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                addRepaintBoundaries: true,
                staggeredTileBuilder: (index) =>
                    const StaggeredTile.count(2, 3),
                crossAxisCount: 4,
                itemBuilder: (context, index) {
                  return Entry.all(
                    delay: const Duration(milliseconds: 50),
                    child: WallCard(
                      index: index,
                      currentWall: snapshotCategory.elementAt(index),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
