import 'package:flutter/cupertino.dart';







extension Responsive on num {

    SizedBox get ph => SizedBox(height: toDouble(),);
    SizedBox get pw => SizedBox(width: toDouble(),);
  }

