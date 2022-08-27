import 'package:flutter/material.dart';

int cellarActiveId = 0;

String splitString(String value) {
  if (value.length <= 25) {
    return value;
  }
  return '${value.substring(0, 25)} ...';
}
