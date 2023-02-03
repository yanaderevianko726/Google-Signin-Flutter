import 'package:boofapp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget getCustomText(
  String text, Color color, int maxLine,
  TextAlign textAlign,
  FontWeight fontWeight,
  double textSizes
) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      decoration: TextDecoration.none,
      fontSize: textSizes,
      color: color,
      fontFamily: Constants.fontsFamily,
      fontWeight: fontWeight
    ),
    maxLines: maxLine,
    textAlign: textAlign,
  );
}

getProgressDialog({
  Color? color
}) {
  return Container(
    decoration:  BoxDecoration(
      color: color ?? CupertinoColors.white,
    ),
    child: color==null ? const Center(
        child: CupertinoActivityIndicator()
      ) : const Center(
        child: CupertinoActivityIndicator(
          color: Colors.white
        )
      )
  );
}