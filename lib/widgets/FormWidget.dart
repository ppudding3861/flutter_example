import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  String? value;
  String hintText; // 힌트 텍스트 추가
  Function(String?) setValue;

  FormWidget({required this.value, required this.setValue, required this.hintText});

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.value,
      decoration: InputDecoration(
        labelText: widget.hintText,
        hintText: widget.hintText, // 전달된 힌트 텍스트를 표시
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "값을 입력해주세요";
        }
        return null;
      },
      onSaved: (value) => widget.setValue(value),
    );
  }
}
