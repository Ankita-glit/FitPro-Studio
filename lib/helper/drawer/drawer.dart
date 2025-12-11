import 'package:flutter/material.dart';
class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.context,
    required this.title,
    required this.onTap,
    required this.image,
    this.trailing = const SizedBox.shrink(),
  });

  final BuildContext context;
  final String title;
  final void Function() onTap;
 final Widget image;
 final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
        leading: image,
        // dense: true,
        onTap: onTap,
        // leading: FlutterLogo(),
        title: Text(title,
            style: TextStyle(
              fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Instrument Sans',
                color: Colors.white)),
      trailing: trailing,
      splashColor: Colors.transparent,
    );
  }
}