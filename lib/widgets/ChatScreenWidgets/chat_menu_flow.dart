import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FlowMenu extends StatefulWidget {
  const FlowMenu({Key? key}) : super(key: key);

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.settings;
  final List<IconData> menuItems = <IconData>[
    Icons.logout,
    Icons.delete,
    Icons.settings,
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.settings) {
      setState(() => lastTapped = icon);
    }
  }

  void clearChat(IconData icon) async{
    _updateMenu(icon);
    menuAnimation.status == AnimationStatus.completed
        ? menuAnimation.reverse()
        : menuAnimation.forward();
    var collection = FirebaseFirestore.instance.collection('messages');
    var snapshot = await collection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  void dispose() {
    super.dispose();
    menuAnimation.dispose();
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  void loopAnimation(IconData icon){
    _updateMenu(icon);
    menuAnimation.status == AnimationStatus.completed
        ? menuAnimation.reverse()
        : menuAnimation.forward();
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / menuItems.length;

    String getMessage(IconData icon){
      if(icon == Icons.logout){
        return 'Logout';
      } else if(icon == Icons.delete){
        return 'Delete Chat';
      } else {
        return 'Settings';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Tooltip(
        message: getMessage(icon),
        child: RawMaterialButton(
          fillColor: lastTapped == icon ? kBubbleBlue : kCoralPink,
          splashColor: kBubbleBlue,
          shape: const CircleBorder(),
          constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
          elevation: 5.0,
          onPressed: () {
            if(icon == Icons.logout){
                _auth.signOut();
                loopAnimation(icon);
                Navigator.pushNamed(context, WelcomeScreen.id);
            } else if(icon == Icons.delete){
                clearChat(icon);
                loopAnimation(icon);
            } else{
                loopAnimation(icon);
            }
          },
          child: Icon(
            icon,
            color: kNavy,
            size: 30.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(menuAnimation: menuAnimation),
      children:
      menuItems.map<Widget>((IconData icon) => flowMenuItem(icon)).toList(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * menuAnimation.value,
          0,
          0,
        ),
      );
    }
  }
}
