import 'package:equatable/equatable.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchServiceEvent extends ServiceEvent {}

class FetchSubCategoriesEvent extends ServiceEvent {
  final String categoryId;
  final int? index;
  FetchSubCategoriesEvent({required this.categoryId, this.index});
}
