import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/models/product_model.dart';
import 'package:hihiienngok/provider/product_provider.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/back_widget.dart';
import 'package:hihiienngok/widgets/empty_products_widget.dart';
import 'package:hihiienngok/widgets/on_sale_widget.dart';
import 'package:hihiienngok/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = '/OnSaleScreen';
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;

    final Utils utils = Utils(context);

    Size size = utils.screenSize;
    final Color color = utils.color;

    return Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Products on sale',
            color: color,
            fontSize: 24,
            isTitle: true,
          ),
        ),
        body: productsOnSale.isEmpty
            ? const EmptyProdWidget(
                text: 'No products on sale yet!, \nStay tuned',
              )
            : GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                // crossAxisSpacing: 10,
                childAspectRatio: size.width / (size.height * 0.49),
                children: List.generate(productsOnSale.length, (index) {
                  return ChangeNotifierProvider.value(
                      value: productsOnSale[index], child: OnSaleWidget());
                  ;
                }),
              ));
  }
}
