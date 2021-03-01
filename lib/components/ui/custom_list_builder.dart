import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

/// Кастомный билдер листа
class CustomListBuilder extends StatelessWidget {
  final EdgeInsets padding;

  final Axis scrollDirection;

  final List<dynamic> items;

  final ScrollPhysics physics;

  final ScrollController controller;

  const CustomListBuilder({
    Key key,
    this.padding = const EdgeInsets.all(0),
    this.scrollDirection = Axis.vertical,
    this.items,
    this.controller,
    this.physics = const BouncingScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller ?? ScrollController(),
      padding: padding,
      shrinkWrap: true,
      reverse: true,
      physics: physics,
      scrollDirection: scrollDirection,
      itemCount: items?.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}
