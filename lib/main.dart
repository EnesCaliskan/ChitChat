import 'package:chat_app/providers/login_provider.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'Helvetica'),
          home: WelcomeScreen(),
          initialRoute: WelcomeScreen.id,
          routes: {
            WelcomeScreen.id: (context) => WelcomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegisterScreen.id: (context) => RegisterScreen(),
            ChatScreen.id: (context) => ChatScreen(),
          },
      ),
    );
  }
}
