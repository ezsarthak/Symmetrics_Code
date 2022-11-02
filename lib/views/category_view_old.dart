// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:main_symmetrics/utils/extensions.dart';
// import '../components/custom_text.dart';
// import '../constants/app_colors.dart';

// class CategoryViewOld extends StatelessWidget {
//   final List<String> categories;
//   final List<String> categoryImagesUrl;

//   const CategoryViewOld({
//     Key? key,
//     required this.categories,
//     required this.categoryImagesUrl,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomText(
//                 textName: 'Categories',
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 textColor: AppColors.primary.withOpacity(0.3),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.transparent,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const CustomText(
//                   textName: 'See All',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,
//                   textColor: AppColors.primary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 0),
//         Container(
//           height: 160,
//           alignment: Alignment.topCenter,
//           // color: Colors.amber.shade100,
//           child: AnimationLimiter(
//             child: Flexible(
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 physics: const BouncingScrollPhysics(),
//                 shrinkWrap: true,
//                 padding: const EdgeInsets.only(left: 20, right: 4),
//                 clipBehavior: Clip.none,
//                 itemCount: categories.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return AnimationConfiguration.staggeredList(
//                     position: index,
//                     duration: const Duration(milliseconds: 375),
//                     child: SlideAnimation(
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 16),
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: AppColors.secondary,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(16),
//                                   child: CachedNetworkImage(
//                                     height: 150,
//                                     width: 130,
//                                     fit: BoxFit.cover,
//                                     imageUrl:
//                                         categoryImagesUrl.elementAt(index),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.only(top: 10, left: 6),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CustomText(
//                                         textName: categories
//                                             .elementAt(index)
//                                             .capitalizeFirstOfEach,
//                                         textColor: AppColors.primaryLight,
//                                         fontSize: 16.5,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       const SizedBox(height: 4),
//                                       CustomText(
//                                         textName: '12 walls',
//                                         textColor: AppColors.primaryLight
//                                             .withOpacity(0.5),
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Container(
// // width: MediaQuery.of(context).size.width * 0.4,
// // height: 150,
// // padding: const EdgeInsets.all(12),
// // alignment: Alignment.center,
// // decoration: BoxDecoration(
// // color: AppColors.secondary,
// // borderRadius: BorderRadius.circular(20),
// // ),
// // child: Stack(
// // alignment: Alignment.bottomLeft,
// // children: [
// // Container(
// // height: MediaQuery.of(context).size.height * 0.08,
// // decoration: BoxDecoration(
// // borderRadius: BorderRadius.circular(20),
// // image: DecorationImage(
// // fit: BoxFit.cover,
// // image: CachedNetworkImageProvider(
// // categoryImagesUrl.elementAt(index),
// // )),
// // ),
// // ),
// // Positioned(
// // bottom: 0,
// // left: 0,
// // child: CustomText(
// // textName: categories.elementAt(index).capitalizeFirstOfEach,
// // textColor: Colors.white,
// // fontSize: 16.5,
// // fontWeight: FontWeight.w500,
// // ),
// // ),
// // ],
// // ),
// // )

// // ClipRRect(
// // borderRadius: BorderRadius.circular(20),
// // child: Container(
// // width: MediaQuery.of(context).size.width * 0.4,
// // decoration: BoxDecoration(
// // image: DecorationImage(
// // fit: BoxFit.cover,
// // image: CachedNetworkImageProvider(
// // categoryImagesUrl.elementAt(index),
// // ),
// // ),
// // ),
// // alignment: Alignment.center,
// // child: CustomText(
// // textName: categories.elementAt(index).capitalizeFirstOfEach,
// // textColor: Colors.white,
// // fontSize: 16.5,
// // fontWeight: FontWeight.w500,
// // ),
// // ),
// // )
