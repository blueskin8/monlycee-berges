import 'package:flutter/material.dart';
import 'package:monlycee/other/get_percentage.dart';

class HomeButton extends StatelessWidget {
  final String buttonText;
  final String imageLogoPath;
  final Widget targetPageInstance;
  final void Function(BuildContext buildContext)? onPress;

  const HomeButton({
    super.key,
    required this.buttonText,
    required this.imageLogoPath,
    required this.targetPageInstance,
    this.onPress,
  });

  Future<void> _defaultOnPress(BuildContext buildContext) async {
    Navigator.push(
      buildContext,
      PageRouteBuilder(pageBuilder: (_, __, ___) => targetPageInstance),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(left: 20),
        backgroundColor: const Color(0xff43497D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: Colors.white, width: 1),
        ),
        fixedSize: Size(
          getPercentage(context, "w43"),
          getPercentage(context, "h15"),
        ),
      ),
      onPressed: () => onPress != null ? onPress!(context) : _defaultOnPress(context),
      child: Row(
        children: [
          Image.asset(imageLogoPath, width: 40),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              buttonText,
              style: TextStyle(
                fontFamily: "FeixenVariable",
                color: Colors.white,
                fontSize: getPercentage(context, "w5"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
