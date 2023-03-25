import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hihiienngok/inner_screens/product_details_screen.dart';
import 'package:hihiienngok/services/global_methods.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/heart_btn.dart';
import 'package:hihiienngok/widgets/price_widget.dart';
import 'package:hihiienngok/widgets/text_widget.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({super.key});

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
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
    Color color = utils.color;

    return Padding(
        padding: EdgeInsets.all(8),
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {
              GlobalMethods.navigateTo(
                  ctx: context, routeName: ProductDetailsScreen.routeName);
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                FancyShimmerImage(
                  imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                  height: size.width * 0.21,
                  width: size.width * 0.2,
                  boxFit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Title',
                        color: color,
                        fontSize: 20,
                        isTitle: true,
                      ),
                      HeartBtn()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 4,
                          child: PriceWidget(
                            isOnSale: true,
                            price: 5.9,
                            salePrice: 2.99,
                            textPrice: _quantityTextController.text,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                          flex: 2,
                          child: Row(
                            children: [
                              FittedBox(
                                  child: TextWidget(
                                text: 'KG',
                                color: color,
                                fontSize: 18,
                                isTitle: true,
                              )),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isEmpty) {
                                      _quantityTextController.text = '1';
                                    } else {}
                                  });
                                },
                                controller: _quantityTextController,
                                key: const ValueKey('10'),
                                style: TextStyle(color: color, fontSize: 18),
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                enabled: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.]'))
                                ],
                              ))
                            ],
                          ))
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).cardColor),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )))),
                    child: TextWidget(
                      text: 'Add to cart',
                      color: color,
                      fontSize: 20,
                      maxLines: 1,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
