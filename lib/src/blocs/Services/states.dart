import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/category/sub_category.dart';
import 'package:hand_bill/src/data/model/paginate/meta.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitialState extends ServiceState {}

class CategoryLoadingState extends ServiceState {}

class CategoryErrorState extends ServiceState {
  final String errors;

  const CategoryErrorState({required this.errors});
}

//  Categories
class CategoriesSuccessState extends ServiceState {
  final List<ServiceCategoryModel>? items;

  const CategoriesSuccessState({required this.items});
}

// subcategories

