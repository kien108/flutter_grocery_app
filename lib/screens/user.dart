import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hihiienngok/provider/dark_theme_provider.dart';
import 'package:hihiienngok/screens/auth/login.dart';
import 'package:hihiienngok/screens/orders/orders_screen.dart';
import 'package:hihiienngok/screens/viewed_recently/viewed_recently.dart';
import 'package:hihiienngok/screens/wishlist/wishlist_screen.dart';
import 'package:hihiienngok/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../services/global_methods.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: '');

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;

    final Color color = _isDark ? Colors.white : Colors.black;

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: 'Hi,  ',
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'MyName',
                      style: TextStyle(
                        color: color,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('My name is pressed');
                        }),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextWidget(
              text: 'Email@gmail.com',
              color: color,
              fontSize: 18,
              // isTitle: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            _listTile(
                title: 'Address 2',
                subTitle: 'My sub title',
                icon: IconlyLight.profile,
                onPressed: () async {
                  await _showAddressDialog();
                },
                color: color),
            _listTile(
                title: 'Orders',
                icon: IconlyLight.bag,
                onPressed: () {
                  GlobalMethods.navigateTo(
                    ctx: context, routeName: OrdersScreen.routeName
                  );
                },
                color: color),
            _listTile(
                title: 'Wishlist',
                icon: IconlyLight.heart,
                onPressed: () {
                  GlobalMethods.navigateTo(
                    ctx: context, routeName: WishlistScreen.routeName
                  );
                },
                color: color),
            _listTile(
                title: 'Viewed',
                icon: IconlyLight.show,
                onPressed: () {
                  GlobalMethods.navigateTo(
                    ctx: context, routeName: ViewedRecentlyScreen.routeName
                  );
                },
                color: color),
            _listTile(
                title: 'Forget password',
                icon: IconlyLight.unlock,
                onPressed: () {},
                color: color),
            _listTile(
                title: 'Logout',
                icon: IconlyLight.logout,
                onPressed: () async {
                  await GlobalMethods.warningDialog(
                    title: "Logout", 
                    subtitle: "Do you want to logout?", 
                    fct: (){
                      GlobalMethods.navigateTo(
                        ctx: context, routeName: LoginScreen.routeName);
                    }, 
                    context: context);
                },
                color: color),
            SwitchListTile(
              title: TextWidget(
                text: _isDark ? 'Dark Theme' : 'Light Theme',
                color: color,
                fontSize: 22,
                // isTitle: true,
              ),
              secondary: Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              onChanged: (bool value) {
                setState(() {
                  themeState.setDarkTheme = value;
                });
              },
              value: themeState.getDarkTheme,
            )
          ],
        ),
      ),
    )));
  }

  // Future<void> _showLogoutDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Row(
  //             children: [
  //               Image.asset('assets/images/warning-sign.png',
  //                   height: 20, width: 20, fit: BoxFit.fill),
  //               const SizedBox(
  //                 width: 10,
  //               ),
  //               Text('Sign out')
  //             ],
  //           ),
  //           content: const Text('Do yout wanna sign out ?'),
  //           actions: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 TextButton(
  //                     onPressed: () {
  //                       if (Navigator.canPop(context)) {
  //                         Navigator.pop(context);
  //                       }
  //                     },
  //                     child: TextWidget(
  //                         text: 'Cancel', color: Colors.cyan, fontSize: 18)),
  //                 TextButton(
  //                     onPressed: () {},
  //                     child: TextWidget(
  //                         text: 'OK', color: Colors.red, fontSize: 18)),
  //               ],
  //             )
  //           ],
  //         );
  //       });
  // }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              onChanged: (value) {
                // _addressTextController.text = value;
              },
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: 'Your address'),
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text('Update')),
            ],
          );
        });
  }

  Widget _listTile(
      {required String title,
      String? subTitle,
      required IconData icon,
      required Function onPressed,
      required Color color}) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        fontSize: 22,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        text: subTitle ?? '',
        color: color,
        fontSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
