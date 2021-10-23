import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/animated_title.dart';
import 'package:chat_app/widgets/main_image.dart';
import 'package:chat_app/widgets/register_login_button.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    //animation controller
    controller = AnimationController(
       duration: Duration(seconds: 3),
       vsync: this,
    );
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    //animation tween
    animation = ColorTween(begin: kBubblePink, end: kBubbleNeon).animate(controller);
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();
      } else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kNavy,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainImage(
                imageHeight: MediaQuery.of(context).size.height / 3,
                imageWidth: MediaQuery.of(context).size.width / 3,
              ),
              SizedBox(
                height: 100,
                width: 200,
                child: AnimatedTitle(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: RegisterLoginButton(
                  buttonText: 'Login',
                  textColor: kBubbleBlue,
                  buttonColor: kBubbleNeon,
                  buttonFunction: (){
                  Navigator.pushNamed(context, LoginScreen.id);
                },),
              ),
              RegisterLoginButton(
                buttonText: 'Register',
                textColor: kBubbleNeon,
                buttonColor: kBubbleBlue
                , buttonFunction: (){
                Navigator.pushNamed(context, RegisterScreen.id);
              },),
            ],
          ),
        ),
      ),
    );
  }
}






