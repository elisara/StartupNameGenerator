import 'package:flutter/material.dart';
import 'dart:math';

Color getRandomColor() {
  final colors = [Colors.yellow, Colors.orange, Colors.lime];
  final random = new Random();
  return colors[random.nextInt(colors.length)];
}
