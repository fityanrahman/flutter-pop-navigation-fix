part of 'list_screen_cubit.dart';

enum ListScreenStatus { initial, loading, success, failure }

final class ListScreenState extends Equatable {
  final List<String>? list;
  final ListScreenStatus status;
  final String? error;

  const ListScreenState({
    this.list = const [],
    this.status = ListScreenStatus.initial,
    this.error,
  });

  ListScreenState copyWith({List<String>? list, ListScreenStatus? status, String? error}) {
    return ListScreenState(
      list: list ?? this.list,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [list, status, error];
}
