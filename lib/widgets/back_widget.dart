import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/screens/btm_bar.dart';
import 'package:hihiienngok/services/global_methods.dart';

import '../services/utils.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({Key? key, this.isBackHome}) : super(key: key);

  final bool? isBackHome;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (isBackHome != null && isBackHome == true) {
          GlobalMethods.navigateTo(
              ctx: context, routeName: BottomBarScreen.routeName);
        } else {
          Navigator.pop(context);
        }
      },
      child: Icon(
        IconlyLight.arrowLeft2,
        color: color,
      ),
    );
  }
}
