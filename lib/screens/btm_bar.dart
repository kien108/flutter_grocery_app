import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/provider/cart_provider.dart';
import 'package:hihiienngok/provider/dark_theme_provider.dart';
import 'package:hihiienngok/screens/cart/cart_screen.dart';
import 'package:hihiienngok/screens/categories.dart';
import 'package:hihiienngok/screens/home_screen.dart';
import 'package:hihiienngok/screens/user.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;

import '../widgets/text_widget.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = "/BottomBar";

  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Home Screen',
    },
    {
      'page': CategoriesScreen(),
      'title': 'Catetories Screen',
    },
    {
      'page': CartScreen(),
      'title': 'Cart Screen',
    },
    {'page': UserScreen(), 'title': 'User Screen'},
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pages[_selectedIndex]['title']),
      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
          selectedItemColor: _isDark ? Colors.lightBlue[200] : Colors.black87,
          onTap: _selectedPage,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: Consumer<CartProvider>(builder: (_, myCart, ch) {
                  return badge.Badge(
                    badgeAnimation: const badge.BadgeAnimation.slide(),
                    badgeStyle: badge.BadgeStyle(
                      shape: badge.BadgeShape.circle,
                      badgeColor: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    position: badge.BadgePosition.topEnd(top: -7, end: -7),
                    badgeContent: FittedBox(
                        child: TextWidget(
                            text: myCart.getCartItems.length.toString(),
                            color: Colors.white,
                            fontSize: 15)),
                    child: Icon(
                        _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
                  );
                }),
                label: 'Buy'),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
                label: 'User')
          ]),
    );
  }
}
