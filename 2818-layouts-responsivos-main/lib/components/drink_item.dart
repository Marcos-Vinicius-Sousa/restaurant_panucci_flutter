import 'package:flutter/material.dart';

class DrinkItem extends StatelessWidget {
  const DrinkItem(
      {Key? key,
      required this.imageURI,
      required this.itemTitle,
      required this.itemPrice,
      required this.discount})
      : super(key: key);
  final String imageURI;
  final String itemTitle;
  final String itemPrice;
  final String discount;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    final itemPriceStyle = TextStyle(
      decoration: brightness == Brightness.dark
          ? TextDecoration.lineThrough
          : TextDecoration.none,
      color: brightness == Brightness.dark ? Colors.grey : null,
      fontSize: 14,
    );

    final discountStyle = TextStyle(
      color: brightness == Brightness.dark ? Colors.green : null,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.surfaceVariant,
      elevation: 0,
      child: Column(
        children: <Widget>[
          Image(
            height: 95,
            width: double.infinity,
            image: AssetImage(imageURI),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  itemTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "R\$ " + itemPrice,
                  style: itemPriceStyle,
                ),
                Visibility(
                  visible: Theme.of(context).brightness == Brightness.dark,
                  child: Text(
                    "R\$ " + discount,
                    style: discountStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
