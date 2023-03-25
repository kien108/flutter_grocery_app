import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/inner_screens/feeds_screen.dart';
import 'package:hihiienngok/inner_screens/on_sale_screen.dart';
import 'package:hihiienngok/provider/dark_theme_provider.dart';
import 'package:hihiienngok/services/global_methods.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/feed_item.dart';
import 'package:hihiienngok/widgets/on_sale_widget.dart';
import 'package:hihiienngok/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/offres/Offer1.jpg',
    'assets/images/offres/Offer2.jpg',
    'assets/images/offres/Offer3.jpg',
    'assets/images/offres/Offer4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);

    bool _isDark = utils.getTheme;
    Size size = utils.screenSize;
    final Color color = utils.color;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.33,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  _offerImages[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: _offerImages.length,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: Colors.red)),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          TextButton(
              onPressed: () {
                GlobalMethods.navigateTo(
                    ctx: context, routeName: OnSaleScreen.routeName);
              },
              child: TextWidget(
                  text: 'View all', color: Colors.blue, fontSize: 20)),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: Row(
                  children: [
                    TextWidget(
                      text: 'On sale'.toUpperCase(),
                      color: Colors.red,
                      fontSize: 22,
                      isTitle: true,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      IconlyLight.discount,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                  child: SizedBox(
                height: size.height * 0.24,
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return OnSaleWidget();
                    }),
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: 'Our products', color: color, fontSize: 22),
                TextButton(
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: FeedsScreen.routeName);
                  },
                  child: TextWidget(
                      text: 'Browser all', color: Colors.blue, fontSize: 20),
                )
              ],
            ),
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.zero,
            crossAxisSpacing: 10,
            childAspectRatio: size.width / (size.height * 0.59),
            children: List.generate(4, (index) {
              return FeedsWidget();
            }),
          )
        ],
      ),
    ));
  }
}
