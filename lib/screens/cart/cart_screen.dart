import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/screens/cart/cart_widget.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/text_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);

    Size size = utils.screenSize;
    final Color color = utils.color;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyBroken.delete),
              color: color,
            )
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Cart (3)',
            color: color,
            fontSize: 22,
            isTitle: true,
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            _checkout(ctx: context),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return CartWidget();
              },
            )),
          ],
        ));
  }

  Widget _checkout({required BuildContext ctx}) {
    final Utils utils = Utils(ctx);

    Size size = utils.screenSize;
    final Color color = utils.color;

    return SizedBox(
        width: double.infinity,
        height: size.height * 0.1,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextWidget(
                          text: 'Order Now', color: Colors.white, fontSize: 20),
                    )),
              ),
              Spacer(),
              FittedBox(
                child: TextWidget(
                  text: 'Total: \$0.259',
                  color: color,
                  fontSize: 18,
                  isTitle: true,
                ),
              )
            ],
          ),
        ));
  }
}
