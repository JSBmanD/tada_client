part of 'main_bloc.dart';

/// Базовый класс состояния экрана проектов
class MainState extends Equatable {
  MainState({
    this.version = 0,
    this.isLoggedIn = false,
    this.rooms,
    this.roomId,
  });

  /// Версия для держании блока в курсе стейта
  final int version;
  final bool isLoggedIn;
  final List<Room> rooms;
  final String roomId;

  @override
  List<Object> get props => [
        version,
        isLoggedIn,
        roomId,
      ];

  MainState copyWith({
    int version,
    bool isLoggedIn,
    List<Room> rooms,
    String roomId,
  }) {
    return MainState(
      version: version ?? this.version,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      rooms: rooms ?? this.rooms,
      roomId: roomId,
    );
  }
}
