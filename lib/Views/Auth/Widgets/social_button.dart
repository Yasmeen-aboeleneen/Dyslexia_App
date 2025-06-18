// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.onpressed,
    required this.title,
    required this.image,
  });
  final VoidCallback onpressed;
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SizedBox(
      width: w,
      height: h * .065,
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: kMGrey, width: 1),
                borderRadius: BorderRadius.circular(16))),
        onPressed: onpressed,
        child: ListTile(
          visualDensity:
              const VisualDensity(vertical: VisualDensity.minimumDensity),
          leading: SvgPicture.asset(
            image,
          ),
          title: Text(
            title,
            style: GoogleFonts.cairo(
              color: kBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
