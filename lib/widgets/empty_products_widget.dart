import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hihiienngok/services/utils.dart';

class EmptyProdWidget extends StatelessWidget {
  const EmptyProdWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;

    return Center(
      child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Image.asset('assets/images/box.png'),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color, fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ],
          )),
    );
  }
}
