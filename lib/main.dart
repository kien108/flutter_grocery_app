import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hihiienngok/consts/theme_data.dart';
import 'package:hihiienngok/inner_screens/feeds_screen.dart';
import 'package:hihiienngok/inner_screens/on_sale_screen.dart';
import 'package:hihiienngok/inner_screens/product_details_screen.dart';
import 'package:hihiienngok/provider/dark_theme_provider.dart';
import 'package:hihiienngok/screens/btm_bar.dart';
import 'package:hihiienngok/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    // fetching theme from shared frefs
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          })
        ],
        child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grocery Store',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: BottomBarScreen(),
            routes: {
              OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
              FeedsScreen.routeName: (ctx) => const FeedsScreen(),
              ProductDetailsScreen.routeName: (ctx) =>
                  const ProductDetailsScreen()
            },
          );
        }));
  }
}
