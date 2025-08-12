import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      title: Text(title,
      style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),),
      leading: Icon(icon,size: 30, color: Colors.white),
      onTap: click,
    );
  }
}
