import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Core/Utils/app_images.dart';
import 'package:dyslexia_app/Views/Home/Widgets/custom_card.dart';
import 'package:dyslexia_app/Views/Home/Widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class CommonSymptoms extends StatefulWidget {
  const CommonSymptoms({
    super.key,
    required this.h,
    required this.w,
    required this.onNext,
  });

  final double h;
  final double w;
  final VoidCallback onNext;

  @override
  State<CommonSymptoms> createState() => _CommonSymptomsState();
}

class _CommonSymptomsState extends State<CommonSymptoms>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _cardAnimations;
  late Animation<double> _imageAnimation;
  bool _showNextButton = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _cardAnimations = [
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
        ),
      ),
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
        ),
      ),
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
        ),
      ),
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
        ),
      ),
    ];

    _imageAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_showNextButton) {
        setState(() {
          _showNextButton = true;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _cardAnimations[0],
            builder: (context, child) {
              return Opacity(
                opacity: _cardAnimations[0].value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - _cardAnimations[0].value)),
                  child: child,
                ),
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomCard(
                text: 'صعوبة في التعرف على الكلمات',
                colors: [kMGrey, kPrimary, kPrimary, kMGrey],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _cardAnimations[1],
            builder: (context, child) {
              return Opacity(
                opacity: _cardAnimations[1].value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - _cardAnimations[1].value)),
                  child: child,
                ),
              );
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomCard(
                text: 'قراءة بطيئة أو غير دقيقة',
                colors: [kMGrey, kPrimary, kPrimary, kMGrey],
              ),
            ),
          ),
          SizedBox(height: widget.h * .02),
          AnimatedBuilder(
            animation: _imageAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _imageAnimation.value,
                child: Transform.scale(
                  scale: 0.5 + 0.5 * _imageAnimation.value,
                  child: child,
                ),
              );
            },
            child: Image.asset(
              Assets.imagesPic6,
              width: widget.w * .7,
              height: widget.h * .3,
            ),
          ),
          SizedBox(height: widget.h * .05),
          AnimatedBuilder(
            animation: _cardAnimations[2],
            builder: (context, child) {
              return Opacity(
                opacity: _cardAnimations[2].value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - _cardAnimations[2].value)),
                  child: child,
                ),
              );
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomCard(
                text: 'صعوبة في التمييز بين الحروف المتشابهة',
                colors: [kMGrey, kPrimary, kPrimary, kMGrey],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _cardAnimations[3],
            builder: (context, child) {
              return Opacity(
                opacity: _cardAnimations[3].value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - _cardAnimations[3].value)),
                  child: child,
                ),
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomCard(
                text: 'صعوبة في التهجئة',
                colors: [kMGrey, kPrimary, kPrimary, kMGrey],
              ),
            ),
          ),
          if (_showNextButton)
            Padding(
              padding: EdgeInsets.only(top: widget.h * 0.05),
              child: CustomElevatedButton(widget: widget),
            ),
        ],
      ),
    );
  }
}
