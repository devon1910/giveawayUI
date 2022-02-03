
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/constants.dart';

import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(56),
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Color(0xFF3F51B5))
                )
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white)
        ),
        onPressed: press,
        child: Text(text,
          style: nextButtonStyle,
            textAlign: TextAlign.center,
          ),
        ),
      );
  }
}