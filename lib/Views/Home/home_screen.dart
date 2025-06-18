import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Utils/app_images.dart';

import 'package:dyslexia_app/Views/MainHome/main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _titleAnimation;
  late Animation<double> _subtitleAnimation;
  late Animation<double> _imageAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3, curve: Curves.easeInOut),
      ),
    );

    _subtitleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );

    _imageAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kveryWhite,
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: h * .1),
            FadeTransition(
              opacity: _titleAnimation,
              child: Text(
                'مرحبا بك في Discovery',
                style: GoogleFonts.cairo(
                  color: kPrimary3,
                  fontWeight: FontWeight.bold,
                  fontSize: w * .07,
                ),
              ),
            ),
            SizedBox(height: h * .01),
            FadeTransition(
              opacity: _subtitleAnimation,
              child: Text(
                'اكتشاف مبكر لعسر القراءة',
                style: GoogleFonts.cairo(
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: w * .048,
                ),
              ),
            ),
            SizedBox(height: h * .02),
            ScaleTransition(
              scale: _imageAnimation,
              child: CircleAvatar(
                radius: w * .5,
                backgroundImage: AssetImage(Assets.imagesDownload),
              ),
            ),
            SizedBox(height: h * .04),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(_buttonAnimation),
              child: FadeTransition(
                opacity: _buttonAnimation,
                child: Padding(
                  padding: EdgeInsets.only(left: w * .15, right: w * .15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainHomeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: h * .065,
                      width: w,
                      decoration: BoxDecoration(
                        color: kPrimary3,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'ابدأ الآن',
                          style: GoogleFonts.cairo(
                            color: kveryWhite,
                            fontSize: w * .052,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
