import 'package:flutter/material.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:monlycee/pages/open_manuel.dart';

class ManuelButtonStyleSheet {
  final String buttonWidth;
  final String buttonHeight;
  final String fontSize;

  const ManuelButtonStyleSheet({
    this.buttonHeight = "h15",
    this.buttonWidth = "w43",
    this.fontSize = "w5"
  });
}


class ManuelButton extends StatelessWidget {
  final String buttonText;
  final ManuelButtonStyleSheet styleSheet;
  final BuildContext? percentageRefContext;
  final String manuelUrl;
  final void Function(BuildContext buildContext, Widget targetPage)? onPress;

  const ManuelButton({
    super.key,
    required this.buttonText,
    required this.manuelUrl,
    this.styleSheet = const ManuelButtonStyleSheet(),
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
        backgroundColor: const Color(0xff43497D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: Colors.white, width: 1),
        ),
        fixedSize: Size(
          getPercentage(percentageRefContext ?? context, styleSheet.buttonWidth),
          getPercentage(percentageRefContext ?? context, styleSheet.buttonHeight),
        ),
      ),
      onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => OpenManuelPage(url: manuelUrl))),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "FeixenVariable",
          color: Colors.white,
          fontSize: getPercentage(percentageRefContext ?? context, styleSheet.fontSize)
        ),
      ),
    );
  }
}