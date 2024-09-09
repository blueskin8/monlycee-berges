import 'package:flutter/material.dart';
import 'package:monlycee/other/get_percentage.dart';

class HomeButtonStyleSheet {
  final String buttonWidth;
  final String buttonHeight;
  final String fontSize;
  final String iconSize;

  const HomeButtonStyleSheet({
    this.buttonHeight = "h15",
    this.buttonWidth = "w43",
    this.fontSize = "w5",
    this.iconSize = "w9"
  });
}

class HomeButton extends StatelessWidget {
  final String buttonText;
  final String imageLogoPath;
  final Widget targetPageInstance;
  final HomeButtonStyleSheet styleSheet;
  final BuildContext? percentageRefContext;
  final void Function(BuildContext buildContext, Widget targetPage)? onPress;

  const HomeButton({
    super.key,
    required this.buttonText,
    required this.imageLogoPath,
    required this.targetPageInstance,
    this.styleSheet = const HomeButtonStyleSheet(),
    this.percentageRefContext,
    this.onPress,
  });

  Future<void> _defaultOnPress(BuildContext buildContext, Widget targetPage) async {
    Navigator.push(
      buildContext,
      PageRouteBuilder(pageBuilder: (_, __, ___) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(left: getPercentage(percentageRefContext ?? context, "w4")),
        backgroundColor: const Color(0xff2b2c39),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: Colors.white, width: 1),
        ),
        fixedSize: Size(
          getPercentage(percentageRefContext ?? context, styleSheet.buttonWidth),
          getPercentage(percentageRefContext ?? context, styleSheet.buttonHeight),
        ),
      ),
      onPressed: () => onPress != null ? onPress!(context, targetPageInstance) : _defaultOnPress(context, targetPageInstance),
      child: Row(
        children: [
          Image.asset(imageLogoPath, width: getPercentage(percentageRefContext ?? context, styleSheet.iconSize)),
          Padding(
            padding: EdgeInsets.only(left: getPercentage(percentageRefContext ?? context, "w4")),
            child: Text(
              buttonText,
              style: TextStyle(
                  fontFamily: "FeixenVariable",
                  color: Colors.white,
                  fontSize: getPercentage(percentageRefContext ?? context, styleSheet.fontSize)
              ),
            ),
          ),
        ],
      ),
    );
  }
}