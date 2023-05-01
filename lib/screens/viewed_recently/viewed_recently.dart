import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/provider/viewed_provider.dart';
import 'package:hihiienngok/provider/wishlist_provider.dart';
import 'package:hihiienngok/screens/viewed_recently/viewed_widget.dart';
import 'package:hihiienngok/widgets/back_widget.dart';
import 'package:hihiienngok/widgets/empty_screen_widget.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';
// import 'viewed_full.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedItems =
        viewedProvider.getViewedItems.values.toList().reversed.toList();

    return viewedItems.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/history.png',
            title: 'Your history is empty',
            subtitle: 'No products has been viewed yet!',
            buttonText: 'Shop now')
        : Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: 'Empty your history?',
                        subtitle: 'Are you sure?',
                        fct: () {},
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                )
              ],
              leading: const BackWidget(),
              automaticallyImplyLeading: false,
              elevation: 0,
              centerTitle: true,
              title: TextWidget(
                text: 'History',
                color: color,
                fontSize: 24.0,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.builder(
                itemCount: viewedItems.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 6),
                      child: ChangeNotifierProvider.value(
                          value: viewedItems[index],
                          child: const ViewedRecentlyWidget()));
                }),
          );
  }
}
