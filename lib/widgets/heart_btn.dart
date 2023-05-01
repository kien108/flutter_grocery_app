import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/consts/firebase_const.dart';
import 'package:hihiienngok/provider/product_provider.dart';
import 'package:hihiienngok/provider/wishlist_provider.dart';
import 'package:hihiienngok/services/global_methods.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:provider/provider.dart';

class HeartBtn extends StatefulWidget {
  const HeartBtn({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool? isInWishlist;

  @override
  State<StatefulWidget> createState() {
    return _HeartBtnState();
  }
}

class _HeartBtnState extends State<HeartBtn> {
  bool isLiked = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;
    final Icon lightHeart = Icon(IconlyLight.heart, size: 22, color: color);
    final Icon filledHeart =
        Icon(Icons.favorite, size: 22, color: Colors.red[400]);

    final wishListProvider = Provider.of<WishListProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.findProductById(widget.productId);

    return GestureDetector(
      onTap: () async {
        setState(() {
          loading = true;
        });
        try {
          final User? user = authInstance.currentUser;

          if (user == null) {
            GlobalMethods.errorDialog(
                subtitle: 'No user found, Please login first',
                context: context);
            return;
          }

          if (widget.isInWishlist == false && widget.isInWishlist != null) {
            await GlobalMethods.addToWishlist(
                productId: widget.productId, context: context);
          } else {
            await wishListProvider.removeOneItem(
                wishlistId: wishListProvider.getWishListItems[product.id]!.id,
                productId: widget.productId);
          }
          await wishListProvider.fetchWishlist();
          setState(() {
            loading = false;
          });
        } catch (error) {
          GlobalMethods.errorDialog(subtitle: '$error', context: context);
        } finally {
          setState(() {
            loading = false;
          });
        }
        // wishListProvider.addToWishList(productId: widget.productId);
      },
      child: loading
          ? const SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(),
            )
          : Icon(
              widget.isInWishlist != null && widget.isInWishlist == true
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              size: 22,
              color: widget.isInWishlist != null && widget.isInWishlist == true
                  ? Colors.red
                  : color),
    );
  }
}
