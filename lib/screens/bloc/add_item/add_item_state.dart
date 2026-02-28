part of 'add_item_cubit.dart';

enum AddItemStatus { initial, loading, success, failure }

final class AddItemState extends Equatable {
  final String? item;
  final AddItemStatus status;
  const AddItemState({this.item, this.status = AddItemStatus.initial});

  AddItemState copyWith({String? item, AddItemStatus? status}) {
    return AddItemState(
      item: item ?? this.item,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [item, status];
}
