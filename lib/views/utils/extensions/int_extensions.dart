import 'package:flutter/material.dart';

extension IntExtensions on int{

  /// sizes
  Widget get height => SizedBox(height: toDouble());
  Widget get width => SizedBox(width: toDouble(),);
  Size get size => Size(toDouble(), toDouble());
  double getHeight({required BuildContext context}) => (MediaQuery.sizeOf(context).height)/this;
  double getWidth({required BuildContext context}) => (MediaQuery.sizeOf(context).width)/this;

  /// durations

  Duration get milliSeconds => Duration(microseconds: toInt());
  Duration get microSeconds => Duration(microseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
  Duration get days => Duration(days: toInt());
  Duration get hours => Duration(hours: toInt());



}