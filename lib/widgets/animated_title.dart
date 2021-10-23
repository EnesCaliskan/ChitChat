import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

class AnimatedTitle extends StatefulWidget {
  const AnimatedTitle({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chit Chat', style: TextStyle(fontSize: 36.0, color: kCoralPink),),
        Expanded(
          child: Row(
            children: [
              Text('Chat ', style: TextStyle(fontSize: 20.0, color: Colors.white),),
              AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    RotateAnimatedText('Better',
                      textStyle: TextStyle(fontSize: 20.0, color: kCoralPink),),
                    RotateAnimatedText('Faster',
                      textStyle: TextStyle(fontSize: 20.0, color: kCoralPink),),
                    RotateAnimatedText('Stronger',
                      textStyle: TextStyle(fontSize: 20.0, color: kCoralPink),),
                    RotateAnimatedText('Safer',
                      textStyle: TextStyle(fontSize: 20.0, color: kCoralPink),),
                  ]),
            ],
          ),
        ),
      ],
    );
  }
}