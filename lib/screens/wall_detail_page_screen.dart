import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../components/custom_button.dart';
import '../components/custom_text.dart';
import '../constants/dimensions.dart';
import '../utils/extensions.dart';
import 'package:photo_view/photo_view.dart';
import '../models/wall_model.dart';
import '../utils/apply_wall.dart';
import '../utils/download_wall.dart';

class WallDetailScreen extends StatefulWidget {
  final WallModel currentWall;

  const WallDetailScreen(
      {Key? key, required this.currentWall,})
      : super(key: key);

  @override
  State<WallDetailScreen> createState() => _WallDetailScreenState();
}

class _WallDetailScreenState extends State<WallDetailScreen> {
  double opacityInfo = 0;
  double opacityApply = 0;
  late PaletteGenerator paletteGenerator;
  bool isLoading = true;
  Color domiColor = Colors.white;
  List<Color>? colors;
  int imageWidth = 0;
  int imageHeight = 0;
  @override
  void initState() {
    super.initState();
    String imageURL = widget.currentWall.thumb ?? widget.currentWall.url!;
    void getImageDimension() {
      Image image = Image.network(imageURL);
      image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener(
          (ImageInfo image, bool synchronousCall) {
            var myImage = image.image;
            setState(() {
              imageHeight = myImage.height.toInt();
              imageWidth = myImage.width.toInt();
            });
          },
        ),
      );
    }

    Future<List<Color>> generateImageColor() async {
      paletteGenerator =
          await PaletteGenerator.fromImageProvider(NetworkImage(imageURL));
      setState(() {
        colors = paletteGenerator.colors.toList();
        domiColor = paletteGenerator.dominantColor!.color;
        isLoading = false;
      });
      debugPrint(colors!.toList().toString());
      return colors!;
    }

    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => generateImageColor());

    // Future.delayed(const Duration()).then((value) => generateImageColor());
    getImageDimension();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: widget.currentWall.id!,
        child: Material(type: MaterialType.transparency, child: buildBody()));
  }

  Widget buildBody() {
    var accentC =
        domiColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    var primaryC =
        domiColor.computeLuminance() > 0.5 ? Colors.white : Colors.black;
    return Scaffold(
      backgroundColor: domiColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        foregroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: domiColor.withOpacity(0.6),
            border: Border.all(
              color: domiColor,
            ),
            borderRadius: BorderRadius.circular(Dimensions.smallCornerRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Iconsax.arrow_left_1,
                  size: 30,
                  color: domiColor.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              // const SizedBox(
              //   width: 24,
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     CustomText(
              //       textName: widget.currentWall.name!.capitalizeFirstOfEach,
              //       textColor: Colors.white,
              //       fontSize: 20,
              //       letterSpacing: 2,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     CustomText(
              //       textName:
              //           widget.currentWall.category!.capitalizeFirstOfEach,
              //       textColor: Colors.white.withOpacity(0.6),
              //       letterSpacing: 1.5,
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: domiColor,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PhotoView(
              loadingBuilder: (context, event) {
                return Center(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.currentWall.thumb!,
                  ),
                ));
              },
              initialScale: PhotoViewComputedScale.covered,
              maxScale: PhotoViewComputedScale.covered * 2,
              minScale: PhotoViewComputedScale.covered,
              imageProvider: CachedNetworkImageProvider(widget.currentWall.url!),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      AnimatedOpacity(
                        curve: Curves.ease,
                        opacity: opacityInfo,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: accentC,
                            borderRadius: BorderRadius.circular(
                                Dimensions.smallCornerRadius),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24.0, horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.53,
                                          child: CustomText(
                                            textName: widget.currentWall.name!
                                                .capitalizeFirstOfEach,
                                            softWrap: true,
                                            textOverflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.035,
                                            textColor: primaryC,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.53,
                                          child: CustomText(
                                            textName: widget.currentWall.category!
                                                .capitalizeFirstOfEach,
                                            softWrap: true,
                                            textOverflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textColor: primaryC,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          opacityInfo = 0;
                                        });
                                      },
                                      icon: Icon(
                                        Iconsax.close_circle,
                                        color: primaryC,
                                        size: 40,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                CustomButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 14),
                                    backgroundColor: domiColor,
                                    buttonContent: CustomText(
                                      textName: "Info",
                                      textColor:
                                          domiColor.computeLuminance() > 0.5
                                              ? Colors.black
                                              : Colors.white,
                                      fontSize: 18,
                                    )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                InfoTile(
                                    title: "Author",
                                    primaryC: primaryC,
                                    end: widget.currentWall.auther!
                                        .capitalizeFirstOfEach),
                                InfoTile(
                                    title: "Dimensions",
                                    primaryC: primaryC,
                                    end: "$imageHeight × $imageWidth"),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: colors?.length ?? 5,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text: colors!
                                                    .elementAt(index)
                                                    .toString()));
                                            void color(Color color) {
                                              Fluttertoast.cancel();
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Color code copied to clipboard",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                textColor:
                                                    color.computeLuminance() > 0.5
                                                        ? Colors.black
                                                        : Colors.white,
                                                backgroundColor: color,
                                              );
                                            }

                                            color(colors?.elementAt(index) ??
                                                Colors.white);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(360),
                                              color: colors?.elementAt(index) ??
                                                  Colors.white,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        backgroundColor: domiColor.withOpacity(0.6),
                        border: Border.all(color: domiColor),
                        buttonContent: Icon(
                          Iconsax.info_circle,
                          color: domiColor.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            if (opacityInfo == 1) {
                              opacityInfo = 0;
                            } else {
                              opacityInfo = 1;
                            }
                          });
                        },
                      ),
                      CustomButton(
                        backgroundColor: domiColor.withOpacity(0.6),
                        border: Border.all(color: domiColor),
                        buttonContent: Icon(
                          Iconsax.document_download4,
                          color: domiColor.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: () async {
                          await downloadWallpaper(
                              context, widget.currentWall.url!);
                        },
                      ),
                      CustomButton(
                        backgroundColor: domiColor.withOpacity(0.6),
                        border: Border.all(color: domiColor),
                        buttonContent: Icon(
                          Iconsax.brush_2,
                          color: domiColor.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: () async {
                          setState(() {
                            opacityInfo = 0;
                          });
                          await setWallpaper(
                            context: context,
                            imgUrl: widget.currentWall.url!,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String end;
  final Color primaryC;
  const InfoTile({
    Key? key,
    required this.title,
    required this.end,
    required this.primaryC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            textName: title,
            textColor: primaryC,
          ),
          CustomText(
            textName: end ?? "",
            textColor: primaryC,
          ),
        ],
      ),
    );
  }
}
