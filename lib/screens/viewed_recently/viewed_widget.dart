import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:hihiienngok/inner_screens/product_details_screen.dart';
import 'package:hihiienngok/services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyWidgetState createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  GestureDetector(
          onTap: () {
            GlobalMethods.navigateTo(
                ctx: context, routeName: ProductDetailsScreen.routeName);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FancyShimmerImage(
                imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                boxFit: BoxFit.fill,
                height: size.width * 0.27,
                width: size.width * 0.25,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  TextWidget(
                    text: 'Title',
                    color: color,
                    fontSize: 24,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextWidget(
                    text: '\$12.88',
                    color: color,
                    fontSize: 20,
                    isTitle: false,
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
