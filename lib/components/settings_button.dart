import 'package:flutter/material.dart';
import 'package:monlycee/other/get_percentage.dart';

class SettingsButtonStyleSheet {
  final String buttonWidth;
  final String buttonHeight;
  final String fontSize;
  final double borderTop;
  final double borderBottom;

  const SettingsButtonStyleSheet({
    this.buttonHeight = "h9",
    this.buttonWidth = "w100",
    this.fontSize = "w7",
    this.borderTop = 0.6,
    this.borderBottom = 0.7
  });
}


class SettingsButton extends StatelessWidget {
  final String buttonText;
  final Widget targetPageInstance;
  final SettingsButtonStyleSheet styleSheet;
  final BuildContext? percentageRefContext;
  final void Function(BuildContext buildContext, Widget targetPage)? onPress;

  const SettingsButton({
    super.key,
    required this.buttonText,
    required this.targetPageInstance,
    this.styleSheet = const SettingsButtonStyleSheet(),
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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          border: Border(bottom: BorderSide(color: Colors.white, width: styleSheet.borderBottom), top: BorderSide(color: Colors.white, width: styleSheet.borderTop as double))
      ),
      width: getPercentage(percentageRefContext ?? context, styleSheet.buttonWidth),
      height: getPercentage(percentageRefContext ?? context, styleSheet.buttonHeight),
      child: ElevatedButton(
        onPressed: () => onPress != null ? onPress!(context, targetPageInstance) : _defaultOnPress(context, targetPageInstance),
        style: ElevatedButton.styleFrom(
            fixedSize: Size(getPercentage(percentageRefContext ?? context, styleSheet.buttonWidth), getPercentage(percentageRefContext ?? context, styleSheet.buttonHeight)),
            backgroundColor: const Color(0xff2A3961),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)
            )
        ),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "FeixenVariable",
              fontSize: getPercentage(percentageRefContext ?? context, styleSheet.fontSize)
          ),
        ),
      ),
    );
  }
}