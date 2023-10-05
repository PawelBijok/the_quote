import 'package:flutter/cupertino.dart';

abstract class Spacers {
  static const xs = SizedBox(
    height: 3,
    width: 3,
  );
  static const s = SizedBox(
    height: 7,
    width: 7,
  );
  static const m = SizedBox(
    height: 13,
    width: 13,
  );
  static const l = SizedBox(
    height: 17,
    width: 17,
  );
  static const xl = SizedBox(
    height: 25,
    width: 25,
  );
  static const xxl = SizedBox(
    height: 35,
    width: 35,
  );

  static SizedBox fromHeight(double height) {
    return SizedBox(
      height: height,
    );
  }

  static SizedBox fromWidth(double width) {
    return SizedBox(
      width: width,
    );
  }
}
