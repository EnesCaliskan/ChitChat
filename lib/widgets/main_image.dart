import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  final double imageHeight;
  final double imageWidth;
  const MainImage({
    Key? key, required this.imageHeight, required this.imageWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Container(
        height: imageHeight,
        width: imageWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bubble.png'),
          ),
        ),
      ),
    );
  }
}