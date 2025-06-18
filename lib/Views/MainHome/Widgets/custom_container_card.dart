import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainerCard extends StatelessWidget {
  const CustomContainerCard({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final Color color;
  final IconData? icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * .2,
        width: w * .45,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: kMGrey,
                blurRadius: 30,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.notoNaskhArabic(
                  color: kveryWhite,
                  fontSize: w * .06,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h * .01,
            ),
            Icon(
              icon,
              color: kveryWhite,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
