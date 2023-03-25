import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hihiienngok/services/utils.dart';
import 'package:hihiienngok/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {Key? key,
      required this.salePrice,
      required this.price,
      required this.textPrice,
      required this.isOnSale})
      : super(key: key);

  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;
    double userPrice = isOnSale ? salePrice : price;

    return FittedBox(
      child: FittedBox(
        child: Row(
          children: [
            TextWidget(
                text:
                    '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
                color: Colors.green,
                fontSize: 18),
            const SizedBox(
              width: 5,
            ),
            Visibility(
                visible: isOnSale,
                child: Text(
                  '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 15,
                      color: color,
                      decoration: TextDecoration.lineThrough),
                ))
          ],
        ),
      ),
    );
  }
}
