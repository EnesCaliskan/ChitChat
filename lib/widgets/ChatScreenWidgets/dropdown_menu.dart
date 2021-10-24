import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';


class BuildDropDownMenu extends StatefulWidget {
  const BuildDropDownMenu({Key? key}) : super(key: key);

  @override
  _BuildDropDownMenuState createState() => _BuildDropDownMenuState();
}

class _BuildDropDownMenuState extends State<BuildDropDownMenu> {

  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: kCoralPink,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _value,
            icon: Icon(Icons.settings, color: kBubbleBlue,),
            elevation: 16,
            onChanged: (int? value){
              setState(() {
                _value = value!;
              });
            },
            items: [
              DropdownMenuItem(
                  child: TextButton(
                    child: Text('Logout', style: TextStyle(fontSize: 16.0, color: kBubbleBlue),),
                    onPressed: (){

                    },
                  ),
                  value: 1,
              ),
              DropdownMenuItem(
                child: TextButton(
                  child: Text('Delete Chat', style: TextStyle(fontSize: 16.0, color: kBubbleBlue),),
                  onPressed: (){

                  },
                ),
                value: 2,
              ),
            ]
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key, required this.function, required this.icon}) : super(key: key);
  final VoidCallback function;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: function,
      icon: icon,
    );
  }
}



