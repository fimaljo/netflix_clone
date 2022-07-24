import 'package:flutter/material.dart';

class SearchTitle extends StatelessWidget {
  final String Title;
  const SearchTitle({
    required this.Title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
