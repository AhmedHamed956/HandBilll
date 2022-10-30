import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
