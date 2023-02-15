// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final String value;
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final dynamic onChanged;
  final int maxLines;
  final bool enabled;

  final IconData suffix;

  final dynamic onSubmitted;
  const Field(
      {Key key, @required this.value,
      @required this.controller,
      this.maxLines = 1,
      @required this.obscure,
      @required this.suffix,
     this.label,
      @required this.enabled,
      this.onSubmitted,
      this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$label:",
                    style: Theme.of(context).textTheme.caption,
                  ),
                )
              : Container(),
          Container(
            // width: 300,
            child: Material(
              color: Colors.transparent,
              child: TextField(
                controller: controller,
                enabled: enabled,
                maxLines: maxLines,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                obscureText: obscure,
                decoration: InputDecoration(
                  isDense: true,

                  filled: true,
                  // fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  labelText: value,
                  floatingLabelBehavior: FloatingLabelBehavior.never,

                  // helperText: 'help',
                  // counterText: 'counter',
                  // icon: Icon(Icons.star),
                  prefixIcon: Icon(suffix),
                  // suffixIcon: Icon(AntDesign.car),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
