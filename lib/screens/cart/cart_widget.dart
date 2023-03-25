import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hihiienngok/inner_screens/product_details_screen.dart';
import 'package:hihiienngok/services/global_methods.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/heart_btn.dart';
import 'package:hihiienngok/widgets/text_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);

    Size size = utils.screenSize;
    final Color color = utils.color;

    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(
                          height: size.width * 0.25,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: InkWell(
                            onTap: () {
                              GlobalMethods.navigateTo(
                                  ctx: context,
                                  routeName: ProductDetailsScreen.routeName);
                            },
                            child: FancyShimmerImage(
                              imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                              boxFit: BoxFit.fill,
                            ),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Title',
                            color: color,
                            fontSize: 20,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: Row(
                              children: [
                                _quantityController(
                                    callback: () {
                                      if (_quantityTextController.text == '1')
                                        return;

                                      setState(() {
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
                                                        .text) -
                                                    1)
                                                .toString();
                                      });
                                    },
                                    color: Colors.red,
                                    icon: CupertinoIcons.minus),
                                Flexible(
                                  child: TextField(
                                    controller: _quantityTextController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide())),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]'))
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          _quantityTextController.text = '1';
                                        } else {}
                                      });
                                    },
                                  ),
                                ),
                                _quantityController(
                                    callback: () {
                                      setState(() {
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
                                                        .text) +
                                                    1)
                                                .toString();
                                      });
                                    },
                                    color: Colors.green,
                                    icon: CupertinoIcons.plus)
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(CupertinoIcons.cart_badge_minus,
                                color: Colors.red, size: 20),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const HeartBtn(),
                          TextWidget(
                            text: '\$0.29',
                            color: color,
                            fontSize: 18,
                            maxLines: 1,
                          )
                        ]),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _quantityController(
      {required Function callback,
      required IconData icon,
      required Color color}) {
    return Flexible(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Material(
            color: color,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  callback();
                },
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                )),
          ),
        ));
  }
}
