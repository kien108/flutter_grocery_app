import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);

    Size size = utils.screenSize;
    bool _isDark = utils.getTheme;
    final Color color = utils.color;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);

    bool? _isInWishList =
        wishListProvider.getWishListItems.containsKey(productModel.id);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            viewedProvider.addToViewed(productId: productModel.id);
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: productModel.id);
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetailsScreen.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: productModel.isPiece ? '1Piece' : '1KG',
                          color: color,
                          fontSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _isInCart
                                  ? null
                                  : () async {
                                      final User? user =
                                          authInstance.currentUser;

                                      if (user == null) {
                                        GlobalMethods.errorDialog(
                                            subtitle:
                                                'No user found, Please login first',
                                            context: context);
                                        return;
                                      }
                                      await GlobalMethods.addToCart(
                                          productId: productModel.id,
                                          quantity: 1,
                                          context: context);
                                      await cartProvider.fetchCart();
                                    },
                              child: Icon(
                                  _isInCart
                                      ? IconlyBold.bag2
                                      : IconlyLight.bag2,
                                  size: 22,
                                  color: _isInCart ? Colors.green : color),
                            ),
                            HeartBtn(
                              productId: productModel.id,
                              isInWishlist: _isInWishList,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                PriceWidget(
                  isOnSale: true,
                  price: productModel.price,
                  salePrice: productModel.salePrice,
                  textPrice: '1',
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: productModel.title,
                  color: color,
                  fontSize: 16,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
