import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/services/utils.dart';

class HeartBtn extends StatelessWidget {
  const HeartBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = utils.color;

    return GestureDetector(
      onTap: () {},
      child: Icon(IconlyLight.heart, size: 22, color: color),
    );
  }
}
