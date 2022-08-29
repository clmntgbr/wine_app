import 'package:flutter/material.dart';

int cellarActiveId = 0;

String splitString(String value, int length) {
  if (value.length <= length) {
    return value;
  }
  return '${value.substring(0, length)} ...';
}
