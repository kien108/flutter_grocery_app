import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hihiienngok/provider/dark_theme_provider.dart';
import 'package:hihiienngok/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.catText,
    required this.cardColor,
    required this.imgPath,
  });

  final String catText, imgPath;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    final Color color = _isDark ? Colors.white : Colors.black;

    return InkWell(
      onTap: () {
        print('category pressed');
      },
      child: Container(
        decoration: BoxDecoration(
            color: cardColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cardColor.withOpacity(0.7), width: 2)),
        child: Column(
          children: [
            Container(
              height: _screenWidth * 0.3,
              width: _screenWidth * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgPath), fit: BoxFit.fill)),
            ),
            TextWidget(
              text: catText,
              color: color,
              fontSize: 20,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
