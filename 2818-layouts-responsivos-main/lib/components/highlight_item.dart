import 'package:flutter/material.dart';
import 'package:panucci_ristorante/remote_config/custom_remote_config.dart';
import 'package:panucci_ristorante/themes/app_colors.dart';

class HighlightItem extends StatelessWidget {
  const HighlightItem(
      {Key? key,
      required this.imageURI,
      required this.itemTitle,
      required this.itemPrice,
      required this.itemDescription,
      required this.discount})
      : super(key: key);
  final String discount;
  final String imageURI;
  final String itemTitle;
  final String itemPrice;
  final String itemDescription;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = CustomRemoteConfig().getValueOrDefault(
      key: 'is_dark_mode',
      defaultValue: false,
    );

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

    final fontColor = isDarkMode ? Colors.white : null;

    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.surfaceVariant,
      elevation: 0,
      child: Column(
        children: <Widget>[
          Image(
            height: 120,
            width: double.infinity,
            image: AssetImage(imageURI),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(itemTitle,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 8.0,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    itemDescription,
                    style: TextStyle(
                      color: fontColor,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: AppColors.buttonStyle,
                    child: const Text('Pedir'),
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
