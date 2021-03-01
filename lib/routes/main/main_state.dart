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
  final bool isLoggedIn;
  final List<Room> rooms;
  final String roomId;
  final String roomName;
  final String firstMessage;
  StreamSubscription<Message> messagesSubscription;
  TextEditingController roomNameController;
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
