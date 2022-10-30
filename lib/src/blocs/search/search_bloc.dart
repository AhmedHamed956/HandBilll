import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/blocs/search/search_state.dart';
import 'package:hand_bill/src/repositories/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String tag = "SearchBloc";

  final SearchRepository searchRepository = SearchRepository();
  int page = 1;
  bool isFetching = false;

  SearchBloc() : super(SearchInitialState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchProductEvent) {
      yield* _mapSearchProduct(event);
    }

    if (event is SearchMarketEvent) {
      yield* _mapSearchCompanies(event);
    }
  }

  Stream<SearchState> _mapSearchProduct(SearchProductEvent event) async* {
    yield SearchProductsLoadingState();
    final response = await searchRepository.getSearchProducts(event.searchKey!);
    try {
      if (response.status!) {
        final products = response.data;
        yield SearchProductsSuccessState(products: products);
      } else {
        yield SearchProductsErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield SearchProductsErrorState(error: err.toString());
    }
  }

  Stream<SearchState> _mapSearchCompanies(SearchMarketEvent event) async* {
    yield SearchCompaniesLoadingState();
    final response = await searchRepository.getSearchCompanies(event.searchKey!);
    try {
      if (response.status!) {
        final companies = response.data;
        yield SearchCompaniesSuccessState(companies: companies);
      } else {
        yield SearchCompaniesErrorState(error: response.message.toString());
      }
    } catch (err) {
      yield SearchCompaniesErrorState(error: err.toString());
    }
  }
}