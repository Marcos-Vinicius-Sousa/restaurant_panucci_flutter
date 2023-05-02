import 'package:flutter/material.dart';
import 'package:panucci_ristorante/cardapio.dart';
import 'package:panucci_ristorante/components/drink_item.dart';

class DrinksMenu extends StatelessWidget {
  const DrinksMenu({super.key});

  final List items = drinks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                "Bebidas",
                style: TextStyle(fontFamily: "Caveat", fontSize: 32),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return DrinkItem(
                    imageURI: items[index]["image"],
                    itemTitle: items[index]["name"],
                    itemPrice: items[index]["price"]);
              }, childCount: items.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 3
                      : 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 1.2
                      : 0.85))
        ],
      ),
    );
    /*return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return DrinkItem(
            imageURI: items[index]["image"],
            itemTitle: items[index]["name"],
            itemPrice: items[index]["price"]);
      },
      itemCount: items.length,
    ); */
  }
}
