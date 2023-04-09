import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/back_widget.dart';
import 'package:hihiienngok/widgets/on_sale_widget.dart';
import 'package:hihiienngok/widgets/text_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = '/OnSaleScreen';
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
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
        body: _isEmpty
            ? Center(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset('assets/images/box.png'),
                        Text(
                          'No products on sale yet!, \nStay tuned',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: color,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
              )
            : GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                // crossAxisSpacing: 10,
                childAspectRatio: size.width / (size.height * 0.49),
                children: List.generate(4, (index) {
                  return OnSaleWidget();
                }),
              ));
  }
}
