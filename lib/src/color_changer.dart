import 'package:flutter/material.dart';
import 'dart:math';

Color getRandomColor() {
  final colors = [Colors.pink, Colors.blue, Colors.green];
  final random = new Random();
  return colors[random.nextInt(3)];
}
