import 'package:flutter/material.dart';

class ButtonHelper {
  static Widget customButton({
    required String title,
    required VoidCallback onTap,
    double width = 200,
    double height = 48,
    Color color = const Color(0xFFCFED51),
    Color textColor = Colors.black,
    double borderRadius = 37,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: color,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontFamily: 'Instrument Sans',
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
