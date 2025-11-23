import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHomeData extends HomeEvent {}

class SelectCategory extends HomeEvent {
  final int categoryId;

  SelectCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
