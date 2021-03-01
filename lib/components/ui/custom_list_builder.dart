import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

/// Кастомный билдер листа
class CustomListBuilder extends StatelessWidget {
  const CustomListBuilder({
    Key key,
    this.items,
    this.controller,
  }) : super(key: key);

  /// Контроллер скролла
  final ScrollController controller;

  /// Дети
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller ?? ScrollController(),
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      reverse: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: items?.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}
