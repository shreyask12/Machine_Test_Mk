import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const ktextInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff00a79b),width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff00a79b),width: 2.0)
  ),
);

class ScreenOptimization {

size({int width ,int height}){
    // print(height);
    // print(width);
    return width == null ? ScreenUtil().setHeight(height) : ScreenUtil().setWidth(width);
  }
}