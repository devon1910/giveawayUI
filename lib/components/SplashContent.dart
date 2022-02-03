
import 'package:flutter/cupertino.dart';

import '../constants.dart';
import '../size_config.dart';

class SplashContent extends StatelessWidget {

  const SplashContent({
    Key? key,
    this.subtext,
    this.subtextContent,
    this.image
  }) : super(key: key);
  final  String? subtext,subtextContent,image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "Spray.mee",
          style: secondaryGiveawayStyle
            //fontSize: getProportionateScreenWidth(36),
        ),
        Spacer(flex: 2),
        Image.asset(image!,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(265),),
        Spacer(flex: 4),
        SizedBox(height: getProportionateScreenHeight(20)),
        Text(subtext!,
            textAlign: TextAlign.center,
            style: subtextStyle
        ),
        Text(subtextContent!,
            textAlign: TextAlign.center,
          style: subtextContentStyle,
        ),
      ],
    );
  }
}