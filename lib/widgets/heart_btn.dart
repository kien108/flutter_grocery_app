import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/services/utils.dart';

class HeartBtn extends StatefulWidget {
  const HeartBtn({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _HeartBtnState();
  }
}

class _HeartBtnState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;
    final Icon lightHeart = Icon(IconlyLight.heart, size: 22, color: color);
    final Icon filledHeart = Icon(Icons.favorite, size: 22, color: color);
    Icon icon = lightHeart;

    return GestureDetector(
      onTap: () {
        if (icon == lightHeart) {
          icon = filledHeart;
        } else {
          icon = lightHeart;
        }
      },
      child: icon,
    );
  }
}
