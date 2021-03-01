import 'package:rxdart/rxdart.dart';
import 'package:tada_client/models/error_model.dart';

/// Сервис ошибок
class ErrorService {
  final _subject = BehaviorSubject<ErrorModel>();

  void addError(ErrorModel error) {
    _subject.add(error);
  }

  Stream<ErrorModel> get events {
    return _subject.stream;
  }
}
