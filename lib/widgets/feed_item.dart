import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hihiienngok/consts/firebase_const.dart';
import 'package:hihiienngok/inner_screens/product_details_screen.dart';
import 'package:hihiienngok/models/product_model.dart';
import 'package:hihiienngok/provider/cart_provider.dart';
import 'package:hihiienngok/provider/viewed_provider.dart';
import 'package:hihiienngok/provider/wishlist_provider.dart';
import 'package:hihiienngok/services/global_methods.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/heart_btn.dart';
import 'package:hihiienngok/widgets/price_widget.dart';
import 'package:hihiienngok/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

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
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    bool? _isWishList =
        wishListProvider.getWishListItems.containsKey(productModel.id);
    final viewedProvider = Provider.of<ViewedProvider>(context);

    return Padding(
        padding: EdgeInsets.all(8),
        child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {
              viewedProvider.addToViewed(productId: productModel.id);

              Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                  arguments: productModel.id);
              // GlobalMethods.navigateTo(
              //     ctx: context, routeName: ProductDetailsScreen.routeName);
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                FancyShimmerImage(
                  imageUrl: productModel.imageUrl,
                  height: size.width * 0.21,
                  width: size.width * 0.2,
                  boxFit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 3,
                          child: TextWidget(
                            text: productModel.title,
                            color: color,
                            fontSize: 18,
                            maxLines: 1,
                            isTitle: true,
                          )),
                      Flexible(
                          flex: 1,
                          child: HeartBtn(
                            productId: productModel.id,
                            isInWishlist: _isWishList,
                          ))
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
                            isOnSale: productModel.isOnSale,
                            price: productModel.price,
                            salePrice: productModel.salePrice,
                            textPrice: _quantityTextController.text,
                          )),
                      const SizedBox(
                        width: 6,
                      ),
                      Flexible(
                          flex: 2,
                          child: Row(
                            children: [
                              FittedBox(
                                  child: TextWidget(
                                text: productModel.isPiece ? 'Piece' : 'kg',
                                color: color,
                                fontSize: 16,
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
                    onPressed: () async {
                      final User? user = authInstance.currentUser;

                      if (user == null) {
                        GlobalMethods.errorDialog(
                            subtitle: 'No user found, Please login first',
                            context: context);
                        return;
                      }

                      if (_isInCart) {
                        return;
                      }
                      await GlobalMethods.addToCart(
                          productId: productModel.id,
                          quantity: int.parse(_quantityTextController.text),
                          context: context);
                      await cartProvider.fetchCart();
                    },
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
                      text: _isInCart ? 'In cart' : 'Add to cart',
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
