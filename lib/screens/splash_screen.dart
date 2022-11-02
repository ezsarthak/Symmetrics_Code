import 'package:flutter/material.dart';
import 'package:main_symmetrics/constants/dimensions.dart';
import 'package:main_symmetrics/screens/nav_bar_screen.dart';
import '../models/wall_model.dart';
import '../services/wall_api.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<WallModel>> wallObject;

  @override
  void initState() {
    wallObject = WallApi.getPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).primaryColorDark,
      extendBodyBehindAppBar: true,
      body: FutureBuilder<List<WallModel>>(
        future: wallObject.whenComplete(
            () => Future.delayed(const Duration(milliseconds: 700))),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return NavBarScreen(
              snapshot: snapshot,
            );
          }
          else {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/app_logo.png'),
                          ),
                          borderRadius: BorderRadius.circular(
                              Dimensions.smallCornerRadius)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 70, right: 70, top: 100),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Dimensions.smallCornerRadius),
                        child: LinearProgressIndicator(
                          backgroundColor: Theme.of(context).cardColor,
                          color: Theme.of(context).indicatorColor,
                          minHeight: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
