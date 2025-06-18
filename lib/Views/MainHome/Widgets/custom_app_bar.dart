import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return  Container(
                height: h * .12,
                width: w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 35,
                          color: kveryWhite,
                          offset: Offset(0, 10))
                    ],
                    color: kDGrey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
                child: Center(
                    child: Text(
                  'Discovery',
                  style: GoogleFonts.cairo(
                    color: kveryWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: w * .088,
                  ),
                )));
  }
}