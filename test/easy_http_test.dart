import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:easy_http/easy_http.dart';

class CustomClass {
  final String text;
  final int value;

  CustomClass({required this.text, required this.value});

  factory CustomClass.fromJson(Map<String, dynamic> json) {
    final text = json['text'];
    final value = json['value'];
    return CustomClass(text:text, value:value);
    }


   Map<String, dynamic> toJson() => {'text': text, 'value': value};

}

void main() {
  test('adds one to input values', () {
  });
}
