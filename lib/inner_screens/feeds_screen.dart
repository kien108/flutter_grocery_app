import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/consts/contss.dart';
import 'package:hihiienngok/models/product_model.dart';
import 'package:hihiienngok/provider/product_provider.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/back_widget.dart';
import 'package:hihiienngok/widgets/empty_products_widget.dart';
import 'package:hihiienngok/widgets/feed_item.dart';
import 'package:hihiienngok/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = '/FeedsScreen';

  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> listProductSearch = [];

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);

    Size size = utils.screenSize;
    final Color color = utils.color;
    final productProviders = Provider.of<ProductProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;

    return Scaffold(
        appBar: AppBar(
          leading: const BackWidget(isBackHome: true),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: TextWidget(
            text: 'All Products',
            color: color,
            fontSize: 20,
            isTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: TextField(
                    focusNode: _searchTextFocusNode,
                    controller: _searchTextController,
                    onChanged: (value) {
                      setState(() {
                        listProductSearch = productProviders.searchQuery(value);
                      });
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1),
                        ),
                        hintText: "What's in your mind",
                        prefixIcon: Icon(Icons.search, color: color),
                        suffix: IconButton(
                            onPressed: () {
                              _searchTextController!.clear();
                              _searchTextFocusNode.unfocus();
                            },
                            icon: Icon(Icons.close,
                                color: _searchTextFocusNode.hasFocus
                                    ? Colors.red
                                    : color))),
                  ),
                ),
              ),
              _searchTextController!.text.isNotEmpty &&
                      listProductSearch.isEmpty
                  ? const EmptyProdWidget(
                      text: 'No products found, please try another keyword')
                  : GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      padding: EdgeInsets.zero,
                      crossAxisSpacing: 10,
                      childAspectRatio: size.width / (size.height * 0.59),
                      children: List.generate(
                          _searchTextController!.text.isNotEmpty
                              ? listProductSearch.length
                              : allProducts.length, (index) {
                        return ChangeNotifierProvider.value(
                            value: _searchTextController!.text.isNotEmpty
                                ? listProductSearch[index]
                                : allProducts[index],
                            child: FeedsWidget());
                        ;
                      }),
                    )
            ],
          ),
        ));
  }
}
