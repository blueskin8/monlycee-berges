import 'package:flutter/material.dart';

double getPercentage(context, String dimension) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  
  if(dimension.startsWith("w")) {
    int widthWished = int.parse(dimension.split("w")[1]);
    return (widthWished / 100) * width;
  } else if (dimension.startsWith("h")) {
    int heightWished = int.parse(dimension.split("h")[1]);
    return (heightWished / 100) * height;
  } else {
    return 0;
  }
}