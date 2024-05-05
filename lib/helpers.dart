

import 'package:flutter/cupertino.dart';

double getHeightFactor(BuildContext context, double ratio){
  return MediaQuery.of(context).size.height * ratio;
}

double getWidthFactor(BuildContext context, double ratio){
  return MediaQuery.of(context).size.width * ratio;
}