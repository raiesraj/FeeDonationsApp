import 'package:flutter/cupertino.dart';


  extension Padding on num {

    SizedBox get ph => SizedBox(height: toDouble(),);
    SizedBox get pw => SizedBox(width: toDouble(),);
  }

