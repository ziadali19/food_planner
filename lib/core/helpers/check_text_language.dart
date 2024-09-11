import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as international;
import 'dart:ui' as ui;

bool isRTL(String text) {
  return international.Bidi.detectRtlDirectionality(text);
}

String setFontFamilyDueToText(String text) {
  return isRTL(text) ? 'LamaSans' : 'IBMPlexSans';
}

Alignment setAlignDueToText(String text) {
  return isRTL(text) ? Alignment.centerRight : Alignment.centerLeft;
}

TextDirection setTextDirectionDueToText(String text) {
  return isRTL(text) ? ui.TextDirection.rtl : ui.TextDirection.ltr;
}
