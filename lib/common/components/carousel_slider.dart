import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mini_project/common/utils/responsive.dart';
import 'package:mini_project/common/utils/screen_type.dart';

class CustomCarousel extends HookWidget {
  late final ScreenType type;

  CustomCarousel({Key? key, required this.type}) : super(key: key);

  final blogImageList = [
    'assets/images/cyberpunk-2077.jpg',
    'assets/images/dying-light-2.jpg',
    'assets/images/god-of-war-4.jpg',
    'assets/images/god-of-war-ragnarok.jpg',
    'assets/images/horizon-forbidden-west.jpg',
    'assets/images/miles-morales.png',
    'assets/images/spider-man.jpg',
  ];

  final rickAndMortyImageList = [
    'assets/images/rick-and-morty-1.png',
    'assets/images/rick-and-morty-2.jpg',
    'assets/images/rick-and-morty-3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: height *
            (Responsive.isMobile(context)
                ? 0.25
                : Responsive.isTablet(context)
                    ? 0.5
                    : 0.75),
        child: Stack(
          children: [
            SizedBox(
              width: width,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: ((type == ScreenType.blog)
                        ? blogImageList
                        : rickAndMortyImageList)
                    .map(
                  (image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                Colors.transparent.withOpacity(0.6),
                                BlendMode.dstATop,
                              ),
                              image: AssetImage(image),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  (type == ScreenType.blog)
                      ? 'Explore the latest games'
                      : 'Rick and Morty Characters',
                  style: TextStyle(
                      fontSize: Responsive.isDesktop(context)
                          ? 60
                          : Responsive.isTablet(context)
                              ? 40
                              : 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
