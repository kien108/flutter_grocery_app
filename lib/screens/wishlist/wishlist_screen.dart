import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/provider/wishlist_provider.dart';
import 'package:hihiienngok/screens/cart/cart_widget.dart';
import 'package:hihiienngok/widgets/empty_screen_widget.dart';
import 'package:hihiienngok/widgets/text_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).screenSize;
    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishListItems =
        wishListProvider.getWishListItems.values.toList().reversed.toList();

    return wishListItems.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/wishlist.png',
            title: 'Your Wishlist Is Empty',
            subtitle: 'Explore more and shortlist some items',
            buttonText: 'Add a wish')
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: const BackWidget(),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'Wishlist (${wishListItems.length})',
                  color: color,
                  isTitle: true,
                  fontSize: 22,
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      await GlobalMethods.warningDialog(
                          title: "Delete",
                          subtitle: "Are you sure to delete?",
                          fct: () async {
                            await wishListProvider.clearOnlineWishlist();

                            wishListProvider.clearLocalWishlist();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: MasonryGridView.count(
              itemCount: wishListItems.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishListItems[index], child: const WishlistWidget());
              },
            ));
  }
}
