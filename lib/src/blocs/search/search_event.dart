import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/model/Search_data.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchProductEvent extends SearchEvent {
  final String? searchKey;

  SearchProductEvent({required this.searchKey});
}

class SearchMarketEvent extends SearchEvent {
  final String? searchKey;

  SearchMarketEvent({required this.searchKey});
}

class SearchAllCategoriesEvent extends SearchEvent{}
class SearchAllSubCategoriesEvent extends SearchEvent{

  final int id;
  SearchAllSubCategoriesEvent({required this.id});

}
