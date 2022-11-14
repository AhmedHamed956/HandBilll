import 'package:equatable/equatable.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchServiceEvent extends ServiceEvent {}
class SearchMarketEvent extends ServiceEvent {
    final String? searchKey;
  SearchMarketEvent({required this.searchKey}){
  }
}
class CategoryEvent extends ServiceEvent {
  final String? searchKey;
  CategoryEvent({required this.searchKey});

}

class FetchSubCategoriesEvent extends ServiceEvent {
  final String categoryId;
  final int? index;
  FetchSubCategoriesEvent({required this.categoryId, this.index});
}
class FetchData extends ServiceEvent{}