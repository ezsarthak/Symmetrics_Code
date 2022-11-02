import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../components/custom_text.dart';
import '../components/wall_card.dart';
import '../models/wall_model.dart';

class SpecialWallsView extends StatefulWidget {
  final AsyncSnapshot<List<WallModel>> snapshotA;
  const SpecialWallsView({Key? key, required this.snapshotA}) : super(key: key);

  @override
  State<SpecialWallsView> createState() => _SpecialWallsViewState();
}

class _SpecialWallsViewState extends State<SpecialWallsView> {
  final List<WallModel> specialWalls = [];
  @override
  void initState() {
    super.initState();
    widget.snapshotA.data?.forEach((element) {
      if (element.special == 1) {
        specialWalls.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            textName: 'Trending Walls',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).textTheme.labelLarge!.color,
          ),
          const SizedBox(
            height: 20,
          ),
          StaggeredGridView.countBuilder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: specialWalls.length,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              addRepaintBoundaries: true,
              staggeredTileBuilder: (index) => const StaggeredTile.count(2, 3),
              crossAxisCount: 4,
              itemBuilder: (context, index) {
                return WallCard(
                  index: index,
                  currentWall: specialWalls.elementAt(index),
                );
              }),
        ],
      ),
    );
  }
}
