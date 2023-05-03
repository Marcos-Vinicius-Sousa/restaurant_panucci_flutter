import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  const FoodItem(
      {Key? key,
      required this.itemTitle,
      required this.itemPrice,
      required this.imageURI,
      required this.discount})
      : super(key: key);
  final String itemTitle;
  final String discount;
  final String itemPrice;
  final String imageURI;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    final itemPriceStyle = TextStyle(
      decoration: brightness == Brightness.dark
          ? TextDecoration.lineThrough
          : TextDecoration.none,
      color: brightness == Brightness.dark ? Colors.grey : null,
    );

    final discountStyle = TextStyle(
      color: brightness == Brightness.dark ? Colors.green : null,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return InkWell(
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: Theme.of(context).colorScheme.surfaceVariant,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    itemTitle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
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
            Image(
              height: 80,
              width: 80,
              image: AssetImage(imageURI),
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
