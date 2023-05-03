import 'package:flutter/material.dart';
import 'package:panucci_ristorante/components/main_drawer.dart';
import 'package:panucci_ristorante/screens/checkout.dart';
import 'package:panucci_ristorante/remote_config/custom_remote_config.dart';
import 'package:panucci_ristorante/screens/drinsk_menu.dart';
import 'package:panucci_ristorante/screens/food_menu.dart';
import 'package:panucci_ristorante/screens/highlights.dart';
import 'package:panucci_ristorante/themes/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRemoteConfig().then((isDark) {
      setState(() {
        isLoading = isDark;
      });
    });
  }

  Future<bool> fetchRemoteConfig() async {
    return CustomRemoteConfig()
        .getValueOrDefault(key: 'isActiveThemeDark', defaultValue: false);
  }

  void _incrementColor() async {
    setState(() => isLoading = true);
    await CustomRemoteConfig().forceFetch();
    setState(() {
      MaterialApp(
        darkTheme: CustomRemoteConfig().getValueOrDefault(
                key: 'isActiveThemeDark', defaultValue: false)
            ? ThemeData.dark()
            : ThemeData(colorSchemeSeed: Colors.purple, useMaterial3: true),
      );
    });
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HighLights(),
      const FoodMenu(),
      const DrinksMenu()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurante Panucci"),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.account_circle,
              size: 32,
            ),
          )
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementColor
        /*Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Checkout();
          })); */
        ,
        child: const Icon(Icons.point_of_sale),
      ),
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: 'Destaques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_bar),
            label: 'Bebidas',
          ),
        ],
        selectedItemColor: AppColors.bottomNavigationBarIconColor,
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pages.elementAt(_currentPage),
    );
  }
}
