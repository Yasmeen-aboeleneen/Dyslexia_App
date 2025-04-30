import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const TestCard(
      {super.key,
      required this.title,
      required this.description,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kveryWhite,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: kPrimary),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: kPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(description,
                        style: TextStyle(fontSize: 14, color: kDGrey)),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: kPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
