import 'package:equatable/equatable.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/category/sub_category.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/paginate/meta.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitialState extends ServiceState {}
class SearchCompanyLoadingState extends ServiceState {}
class CategoryLoadingState extends ServiceState {}
class searchSuccess extends ServiceState {
List<Company>? company;
searchSuccess({required this.company});
}
class SearchCompaniesErrorState extends ServiceState{
  final String errors;
  const SearchCompaniesErrorState({required this.errors});
}

class CategoryErrorState extends ServiceState {
  final String errors;

  const CategoryErrorState({required this.errors});
}
class getCompnyErrorState extends ServiceState {
  final String errors;

  const getCompnyErrorState({required this.errors});
}
class CategoriesAddSuccessState extends ServiceState{
  List<ServiceCategoryModel>? items;
  CategoriesAddSuccessState({required this.items}){
    print('ddddddddffdfdfdfdfdfdfdf');
    print(items!.first.name);
  }

}
class getCompnySuccessState extends ServiceState{
  List<Company>? company;
  getCompnySuccessState({required this.company}){
    print('ddddddddffdfdfdfdfdfdfdf');
    print(company!.first.name);
  }

}

class categoryLoadState extends ServiceState{}
class categorySuccessState extends ServiceState{
 final List<ServiceModel>? items;
  categorySuccessState({required this.items}){
    print('dldldldldldldldldldd');
    print(items!.first.name);
  }
}
class categoryErrorState extends ServiceState{}
class CategoriesAddLoadingState extends ServiceState{}
class CategoriesAddErrorState extends ServiceState{}
//  Categories
class CategoriesSuccessState extends ServiceState {
  final List<ServiceCategoryModel>? items;

   CategoriesSuccessState({required this.items}){
    print('ddddddddffdfdfdfdfdfdfdf');
    print(items!.first.name);
  }
}

// subcategories

