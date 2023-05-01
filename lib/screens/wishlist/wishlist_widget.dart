import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/inner_screens/product_details_screen.dart';
import 'package:hihiienngok/models/wishlist_modal.dart';
import 'package:hihiienngok/provider/product_provider.dart';
import 'package:hihiienngok/provider/wishlist_provider.dart';
import 'package:hihiienngok/services/global_methods.dart';
import 'package:hihiienngok/widgets/heart_btn.dart';
import 'package:hihiienngok/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    final productProviders = Provider.of<ProductProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    final wishListModel = Provider.of<WishlistModel>(context);

    final product = productProviders.findProductById(wishListModel.productId);
    double usedPrice = product.isOnSale ? product.salePrice : product.price;

    bool? _isInWishList =
        wishListProvider.getWishListItems.containsKey(product.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailsScreen.routeName,
              arguments: wishListModel.productId);
        },
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    // width: size.width * 0.2,
                    height: size.width * 0.25,
                    child: FancyShimmerImage(
                      imageUrl: product.imageUrl,
                      boxFit: BoxFit.fill,
                    ),
                  )),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.bag2,
                              color: color,
                            ),
                          ),
                          HeartBtn(
                            productId: product.id,
                            isInWishlist: _isInWishList,
                          ),
                        ],
                      ),
                    ),
                    TextWidget(
                      text: product.title,
                      color: color,
                      fontSize: 20.0,
                      maxLines: 2,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: '\$${usedPrice.toStringAsFixed(2)}',
                      color: color,
                      fontSize: 18.0,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
