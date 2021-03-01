part of 'main_bloc.dart';

/// Базовый класс состояния экрана проектов
class MainState extends Equatable {
  MainState({
    this.version = 0,
    this.isLoggedIn = false,
    this.messagesSubscription,
    this.rooms,
    this.roomId,
    this.roomName,
    this.firstMessage,
    this.roomNameController,
    this.firstMessageController,
  }) {
    this.roomNameController = roomNameController ?? TextEditingController();
    this.firstMessageController =
        firstMessageController ?? TextEditingController();
  }

  /// Версия для держании блока в курсе стейта
  final int version;

  /// Юзер залогинен
  final bool isLoggedIn;

  /// Комнаты
  final List<Room> rooms;

  /// Ид комнаты для открытия
  final String roomId;

  /// Имя комнаты
  final String roomName;

  /// Первое сбщ
  final String firstMessage;

  /// Подписка на новые сообщения
  StreamSubscription<Message> messagesSubscription;

  /// Контроллер румы
  TextEditingController roomNameController;

  /// Контроллер сбщ
  TextEditingController firstMessageController;

  @override
  List<Object> get props => [
        version,
        isLoggedIn,
        roomId,
        roomName,
        firstMessage,
      ];

  MainState copyWith({
    int version,
    bool isLoggedIn,
    bool loadingData,
    List<Room> rooms,
    String roomId,
    String roomName,
    String firstMessage,
    TextEditingController roomNameController,
    TextEditingController firstMessageController,
    StreamSubscription<Message> messagesSubscription,
  }) {
    return MainState(
      version: version ?? this.version,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      messagesSubscription: messagesSubscription ?? this.messagesSubscription,
      rooms: rooms ?? this.rooms,
      roomName: roomName ?? this.roomName,
      firstMessage: firstMessage ?? this.firstMessage,
      roomNameController: roomNameController ?? this.roomNameController,
      firstMessageController:
          firstMessageController ?? this.firstMessageController,
      roomId: roomId,
    );
  }
}
