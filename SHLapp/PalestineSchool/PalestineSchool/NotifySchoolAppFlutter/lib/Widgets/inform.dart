import 'package:flutter/material.dart';

class Inform extends StatefulWidget {
  Inform({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Inform> createState() => _InformState();
}

class _InformState extends State<Inform> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Color.fromRGBO(76, 175, 80, 1),
      // ignore: unnecessary_string_interpolations
      child: Text('${widget.title}'),
    );
  }
}
