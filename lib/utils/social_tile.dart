import 'package:flutter/material.dart';

class SocialTile extends StatelessWidget {
  final String assetUrl; //kalo tha itan na exw ena fallback gia null
  final Function onClickFunction;
  const SocialTile(
      {super.key, required this.assetUrl, required this.onClickFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClickFunction();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12)),
        child: Image.asset(
          assetUrl,
          height: 40,
        ),
      ),
    );
  }
}
