import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String account;

  const Header({
    Key? key,
    this.title = "",
    this.account = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline2?.fontSize,
          ),
        ),
        Card(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded),
                Text(
                  "Account: $account",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline3?.fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
