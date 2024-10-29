import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:main_symmetrics/constants/dimensions.dart';
import 'package:main_symmetrics/screens/wall_detail_page_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/custom_text.dart';
import '../models/wall_model.dart';

class SwiperCarousel extends StatefulWidget {
  final AsyncSnapshot<List<WallModel>> snapshot;
  const SwiperCarousel({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<SwiperCarousel> createState() => _SwiperCarouselState();
}

class _SwiperCarouselState extends State<SwiperCarousel> {
  int newIndex = 0;
  List<WallModel> swiper = [];
  @override
  void initState() {
    super.initState();
    widget.snapshot.data!.forEach((element) {
      if (element.banner == 1) {
        swiper.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomText(
            textName: 'Suggested',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).textTheme.labelLarge!.color,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: swiper.length,
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(milliseconds: 5000),
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.width * 0.6,
                  onPageChanged: (index, pageChangeReason) {
                    setState(() {
                      newIndex = index;
                    });
                  }),
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) {
                return Hero(
                  tag: swiper.elementAt(index).id!,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => WallDetailScreen(
                                    isswiper: true,
                                    currentWall: swiper.elementAt(index),
                                  ))));
                      // String url = swiper.elementAt(newIndex).bannerLaunchUrl!;
                      // if (await canLaunch(url)) {
                      //   await launch(url);
                      // }
                    },
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.low,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            value: progress.progress,
                            color:
                                Theme.of(context).textTheme.labelLarge!.color,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                      fit: BoxFit.fill,
                      imageUrl: swiper.elementAt(index).bannerLaunchUrl!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(
                                Dimensions.smallCornerRadius),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            // Swiper(
            //   itemCount: swiper.length,
            //   viewportFraction: 0.8,
            //   // scale: 0.9,
            //   itemWidth: screenWidth,
            //   itemHeight: 230,
            //   // autoplay: true,
            //   // autoplayDelay: 5000,
            //   onTap: (int tapIndex) async {
            //     String url = swiper.elementAt(tapIndex).bannerLaunchUrl!;
            //     if (await canLaunch(url)) {
            //       await launch(url);
            //     }
            //     // Navigator.push(context, CupertinoPageRoute(builder: (context) {
            //     //   return WallDetailScreen(
            //     //       currentWall: widget.snapshot.data!.elementAt(tapIndex));
            //     // }));
            //   },
            //   onIndexChanged: (index) {

            //   },
            //   itemBuilder: (context, index) {

            //   },
            // ),
            const SizedBox(height: 16),
            AnimatedSmoothIndicator(
              activeIndex: newIndex,
              count: swiper.length,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 250),
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Theme.of(context).textTheme.labelMedium!.color!,
                activeDotColor: Theme.of(context).indicatorColor,
                type: WormType.thin,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// scrollDirection: Axis.vertical,
// containerHeight: 300,
// itemBuilder: (BuildContext context, int index) {
// return Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(32),
// image: DecorationImage(
// fit: BoxFit.cover,
// image: CachedNetworkImageProvider(
// snapshot.data!.elementAt(index).url!,
// ),
// ),
// ),
// );
// },
// physics: const BouncingScrollPhysics(),
// itemCount: snapshot.data!.length,
// pagination: SwiperPagination(
// alignment: Alignment.bottomCenter,
// ),
// // pagination: SwiperCustomPagination(
// //   builder: (context, config) {
// //     return AnimatedSmoothIndicator(
// //       activeIndex: config.activeIndex,
// //       count:  config.itemCount,
// //       effect:  const WormEffect(),
// //     );
// //   }
// // ),
// itemWidth: screenWidth,
// // viewportFraction: 0.8,
// itemHeight: MediaQuery.of(context).size.height * 0.28,
// layout: SwiperLayout.TINDER,
