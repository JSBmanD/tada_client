/// Класс тикера со стримами
class CustomTicker {
  /// [Сплеш] Тикер каждую секунду вычитает из числа тиков 1 и оповещает подписавшихся
  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
