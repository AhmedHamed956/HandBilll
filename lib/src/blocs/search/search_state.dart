import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/market.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/response/search/search_companies_response.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

//// products

class SearchProductsLoadingState extends SearchState {}

class SearchProductsSuccessState extends SearchState {
  final List<Product>? products;

  const SearchProductsSuccessState({required this.products});
}

class SearchProductsErrorState extends SearchState {
  final String error;

  const SearchProductsErrorState({required this.error});
}

//// companies

class SearchCompaniesLoadingState extends SearchState {}

class SearchCompaniesSuccessState extends SearchState {
  final List<Company>? companies;

  const SearchCompaniesSuccessState({required this.companies});
}

class SearchCompaniesErrorState extends SearchState {
  final String error;

  const SearchCompaniesErrorState({required this.error});
}
