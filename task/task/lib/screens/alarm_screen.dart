import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StackOfCards(
      child: Container(
        height: 500,
        width: 500,
      ),
      num: 5,
    );
  }
}

class StackOfCards extends StatelessWidget {
  final int num;
  final Widget child;
  final double offset;

  const StackOfCards({int num = 1, required this.child, this.offset = 10.0})
      : this.num = num > 0 ? num : 1,
        assert(offset != null);

  @override
  Widget build(BuildContext context) => Stack(
        children: List<Widget>.generate(
            num - 1,
            (val) => Positioned(
                bottom: val * offset,
                left: val * offset,
                top: (num - val - 1) * offset,
                right: (num - val - 1) * offset,
                child: Card(child: Container()))).toList()
          ..add(
            Padding(
              child: Card(child: child),
              padding: EdgeInsets.only(
                  bottom: (num - 1) * offset, left: (num - 1) * offset),
            ),
          ),
      );
}
