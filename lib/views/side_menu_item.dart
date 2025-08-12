import 'package:flutter/material.dart';

//Widget para items en la barra lateral en pantalla home:

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.click,
  });

  final String title;
  final IconData icon;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.normal)),
      leading: Icon(icon),
      onTap: click,
    );
  }
}
