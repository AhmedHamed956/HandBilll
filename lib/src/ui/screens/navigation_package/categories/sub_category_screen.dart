// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_translate/flutter_translate.dart';

// import '../../../../blocs/category/category_bloc.dart';
// import '../../../../blocs/category/category_event.dart';
// import '../../../../blocs/category/category_state.dart';
// import '../../../../data/model/category/category.dart';
// import '../../../../data/model/category/sub_category.dart';
// import '../../../../data/model/local/route_argument.dart';
// import '../../../component/custom/regular_app_bar.dart';
// import '../../../component/widgets.dart';
// import 'component/category_empty_widget.dart';
// import 'component/category_widget.dart';
// import 'component/sub_category_empty_widget.dart';
// import 'component/sub_category_widget.dart';

// class SubCategories extends StatefulWidget {
//   static const routeName = "/subcat";
//   late final RouteArgument? routeArgument;

//   SubCategories({required this.routeArgument});

//   @override
//   State<SubCategories> createState() => _SubCategoriesState();
// }

// class _SubCategoriesState extends State<SubCategories> {
//   List<SubCategoryModel>? _subCategories;

//   double offsetVisibleThreshold = 100;

//   CategoryModel? _selectedCategory;
//   CategoryBloc? _categoryBloc;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     _categoryBloc = BlocProvider.of<CategoryBloc>(context);
//     _categoryBloc!.add(FetchSubCategoriesEvent(
//         categoryId: widget.routeArgument!.id.toString()));
//     // if (_categoryBloc!.categories == null ||
//     //     _categoryBloc!.categories!.length == 0)
//     //   _categoryBloc!..add(FetchCategoriesEvent());
//     // if (_categoryBloc!.subCategories == null ||
//     //     _categoryBloc!.subCategories!.length == 0)
//     //   _categoryBloc!
//     //     ..add(FetchSubCategoriesEvent(
//     //         categoryId: _categoryBloc!.categories!.first.id.toString()));
//     // if (_categoryBloc!.subCategories != null &&
//     //     _categoryBloc!.categories!.length != 0) {
//     // _subCategories = _categoryBloc!.subCategories;
//     // }
//     // SchedulerBinding.instance!.addPostFrameCallback((_) {
//     //   if (_categories != null) {
//     //     setState(() {
//     //       _categories![0].selected = true;
//     //       _selectedCategory = _categories![0];
//     //     });
//     //   }
//     // });
//     // _scrollController = ScrollController()..addListener(_onScroll);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // _scrollController!.dispose();
//     super.dispose();
//   }

//   bool _showRealLength = false;
//   int? _showRealSubLengthIndex;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: RegularAppBar(label: '${widget.routeArgument?.param}'),
//         body: RefreshIndicator(
//           onRefresh: () async {},
//           child: BlocBuilder<CategoryBloc, CategoryState>(
//               builder: (context, state) {
//             if (state is SubCategoriesSuccessState) {
//               if (_subCategories == null) {
//                 _subCategories = [];
//               }
//               if (_selectedCategory != null &&
//                   state.items != null &&
//                   state.items!.length != 0) {
//                 print('null');

//                 if (_showRealLength == false) {
//                   print('null');

//                   SchedulerBinding.instance?.addPostFrameCallback((_) {
//                     setState(() {
//                       _showRealLength = true;
//                     });
//                   });
//                 }
//                 if (_subCategories!.length != 0 &&
//                     _subCategories!.first.id != state.items!.first.id) {
//                   _subCategories!.addAll(state.items!);
//                 } else if (_subCategories!.length == 0) {
//                   _subCategories!.addAll(state.items!);
//                 }
//               }
//             }

//             return

//                 // Expanded(
//                 //     flex: 3,
//                 //     child: Container(
//                 //         padding: EdgeInsets.only(bottom: 40),
//                 //         decoration: BoxDecoration(
//                 //             color: Color(0xffffffff),
//                 //             border: Border.symmetric(
//                 //                 vertical:
//                 //                     BorderSide(color: Color(0xffeeeeee)))),
//                 //         child: _categoryBloc!.categories == null
//                 //             ? ListView.builder(
//                 //                 shrinkWrap: true,
//                 //                 physics: BouncingScrollPhysics(),
//                 //                 itemCount: 6,
//                 //                 itemBuilder: (context, index) {
//                 //                   return CategoryEmptyWidget();
//                 //                 })
//                 //             : ListView.builder(
//                 //                 shrinkWrap: true,
//                 //                 physics: BouncingScrollPhysics(),
//                 //                 itemCount: _categoryBloc!.categories!.length,
//                 //                 itemBuilder: (context, index) {
//                 //                   if (_categoryBloc!.categories!.isNotEmpty) {
//                 //                     return CategoryWidget(
//                 //                         model:
//                 //                             _categoryBloc!.categories![index],
//                 //                         onTap: () => onCategoryTap(
//                 //                             _categoryBloc!.categories![index]));
//                 //                   }
//                 //                   return CategoryEmptyWidget();
//                 //                 }))),
//                 ListView(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(bottom: 30),
//                   margin: EdgeInsets.only(left: 6, right: 8),
//                   child: Column(children: [
//                     _subCategories == null || _subCategories!.length == 0
//                         ? ListView.separated(
//                             padding: EdgeInsets.symmetric(vertical: 12),
//                             primary: false,
//                             shrinkWrap: true,
//                             itemCount: 4,
//                             itemBuilder: (BuildContext context, int index) {
//                               return SubCategoryEmptyWidget();
//                             },
//                             separatorBuilder:
//                                 (BuildContext context, int index) =>
//                                     SizedBox(height: 8))
//                         : ListView.separated(
//                             padding: EdgeInsets.symmetric(vertical: 12),
//                             primary: false,
//                             shrinkWrap: true,
//                             itemCount: _showRealLength == true
//                                 ? _subCategories!.length
//                                 : (_subCategories!
//                                             .first.subSubCategory!.length >
//                                         6
//                                     ? 1
//                                     : 2),
//                             itemBuilder: (BuildContext context, int index) {
//                               return Stack(
//                                 alignment: Alignment.bottomRight,
//                                 children: [
//                                   SubCategoryWidget(
//                                       realLength: _showRealSubLengthIndex !=
//                                                   null &&
//                                               _showRealSubLengthIndex == index
//                                           ? _subCategories![index]
//                                               .subSubCategory!
//                                               .length
//                                           : (_subCategories![index]
//                                                       .subSubCategory!
//                                                       .length >
//                                                   10
//                                               ? 10
//                                               : (_subCategories![index]
//                                                           .subSubCategory!
//                                                           .length >=
//                                                       5
//                                                   ? 5
//                                                   : 1)),
//                                       model: _subCategories![index]),
//                                   if (_subCategories![index]
//                                               .subSubCategory!
//                                               .length !=
//                                           0 &&
//                                       _subCategories![index]
//                                               .subSubCategory!
//                                               .length >
//                                           3)
//                                     Align(
//                                       alignment: Alignment.bottomRight,
//                                       child: GestureDetector(
//                                           onTap: () async {
//                                             setState(() {
//                                               _showRealSubLengthIndex = index;
//                                             });
//                                           },
//                                           child: Container(
//                                             color: Colors.white,
//                                             margin: EdgeInsets.symmetric(
//                                                 horizontal: 15.w,
//                                                 vertical: 20.h),
//                                             child: RichText(
//                                               softWrap: true,
//                                               maxLines: 2,
//                                               textAlign: TextAlign.center,
//                                               text: TextSpan(children: [
//                                                 if (_showRealSubLengthIndex !=
//                                                     index)
//                                                   TextSpan(
//                                                     text: translate(
//                                                         "button.show_more"),
//                                                     style: TextStyle(
//                                                       color: Colors.blue
//                                                           .withOpacity(0.5),
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       decoration: TextDecoration
//                                                           .underline,
//                                                       fontSize: 25.sp,
//                                                     ),
//                                                   ),
//                                                 TextSpan(text: " "),
//                                               ]),
//                                             ),
//                                           )),
//                                     ),
//                                 ],
//                               );
//                             },
//                             separatorBuilder:
//                                 (BuildContext context, int index) =>
//                                     SizedBox(height: 8)),
//                   ]),
//                 ),
//               ],
//             );
//           }),
//         ));
//   }
// }

import 'dart:async';
import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hand_bill/src/blocs/category/category_bloc.dart';
import 'package:hand_bill/src/blocs/category/category_event.dart';
import 'package:hand_bill/src/blocs/category/category_state.dart';
import 'package:hand_bill/src/common/global.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_empty_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_category_empty_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_category_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/sub_sub_categories.dart';

import '../../../../common/constns.dart';
import '../../../../data/model/category/sub.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../../component/custom/regular_app_bar.dart';
import '../../services_package/shipping/cubit.dart';
import '../../services_package/shipping/states.dart';

class SubCategories extends StatefulWidget {
  static const routeName = "/subcat";
  late final RouteArgument? routeArgument;

  SubCategories({required this.routeArgument});
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories>
    with SingleTickerProviderStateMixin {
  // List<CategoryModel>? _categories;

  // List<SubCategoryModel>? _subCategories;

  // ScrollController? _scrollController;
  // double offsetVisibleThreshold = 100;

  // CategoryModel? _selectedCategory;
  // CategoryBloc? _categoryBloc;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
late String id;
  @override
  void initState() {
    id = widget.routeArgument!.id!;
    print(widget.routeArgument!.id);
    print(id);
    print('ddddddddddddd');
    // _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    // if (_categoryBloc!.categories == null ||
    //     _categoryBloc!.categories!.length == 0)
    //   _categoryBloc!..add(FetchCategoriesEvent());
    // if (_categoryBloc!.subCategories == null ||
    //     _categoryBloc!.subCategories!.length == 0)
    //   _categoryBloc!
    //     ..add(FetchSubCategoriesEvent(
    //         categoryId: widget.routeArgument!.id.toString()));
    // if (_categoryBloc!.subCategories != null &&
    //     _categoryBloc!.categories!.length != 0) {
    //   _subCategories = _categoryBloc!.subCategories;
    // }
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   if (_categories != null) {
    //     setState(() {
    //       _categories![0].selected = true;
    //       _selectedCategory = _categories![0];
    //     });
    //   }
    // });
    // _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController!.dispose();
    super.dispose();
  }

  // bool _showRealLength = false;
  // int? _showRealSubLengthIndex;
  // void _onScroll() {
  //   final max = _scrollController!.position.maxScrollExtent;
  //   final offset = _scrollController!.offset;
  //   if (offset + offsetVisibleThreshold >= max && !_categoryBloc!.isFetching) {
  //     _categoryBloc!.isFetching = true;
  //     if (_selectedCategory == null)
  //       _selectedCategory = _categoryBloc!.categories!.first;
  //     if (_showRealLength == false)
  //       setState(() {
  //         _showRealLength = true;
  //       });
  //     Timer(Duration(seconds: 6), () {
  //       _categoryBloc!.add(FetchSubCategoriesEvent(
  //           categoryId: _selectedCategory!.id.toString()));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var model;
    return BlocProvider(
      create: ((context) => ShippingBloc()..getSubCategories(id: id)),
      child: BlocConsumer<ShippingBloc, InterState>(
        listener: (context, state) {
          if (state is ShopIntresSuccessStates) {
            print('omniaaaaaaaaaaaaaaaaaaaaa');
          }
          if (state is ShopIntresErrorStates) {
            print('dddddsdssdssssssss');
          }
        },
        builder: (context, state) {
          model = ShippingBloc.get(context).subCategoryModel;
          return Scaffold(
            backgroundColor: Color(0xfff5f5f5),
            appBar:
                RegularAppBar(label: widget.routeArgument!.param.toString()),
            body: ConditionalBuilder(
              condition: ShippingBloc.get(context).subCategoryModel != null,
              builder: (context) => item(model),
              fallback: (context) => Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
        // builder: (context, state) {
        //   var model = ShippingBloc.get(context).companyModel;
        //   return Scaffold(
        //       backgroundColor: Color(0xfff5f5f5),
        //       appBar:
        //           RegularAppBar(label: widget.routeArgument!.param.toString()),
        //       body: ConditionalBuilder(
        //         condition: ShippingBloc.get(context).companyModel != null,
        //         builder: (context) => item(model!),
        //         fallback: (context) => Container(
        //           color: Colors.white,
        //           child: Center(
        //             child: CircularProgressIndicator(),
        //           ),
        //         ),
        //       ));

        //   // return Scaffold(
        //   //   backgroundColor: Color(0xfff5f5f5),
        //   //   appBar:
        //   //       RegularAppBar(label: widget.routeArgument!.param.toString()),
        //   //   body: ConditionalBuilder(
        //   //     condition: ShippingBloc.get(context).companyModel != null,
        //   //     // HomeCubit.get(context).showFriendsModel != null,
        //   //     builder: (context) {
        //   //       return ListView.separated(
        //   //           physics: BouncingScrollPhysics(),
        //   //           // padding: EdgeInsets.symmetric(vertical: 16),
        //   //           primary: false,
        //   //           shrinkWrap: true,
        //   //           itemCount: model!.data!.length,
        //   //           scrollDirection: Axis.vertical,
        //   //           itemBuilder: (context, index) {
        //   //             return ShapWidget(
        //   //               model: model.data.firs[index],
        //   //             );
        //   //           },
        //   //           separatorBuilder: (BuildContext context, int index) =>
        //   //               Container(height: 10, color: Color(0xffeeeeee)));
        //   //     },
        //   //     fallback: (context) => Container(
        //   //       color: Colors.white,
        //   //       child: Center(
        //   //         child: CircularProgressIndicator(),
        //   //       ),
        //   //     ),
        //   //     // builder: (BuildContext context, AsyncSnapshot snapshot) {
        //   //     //   if (HomeCubit.get(context).categoriesModel.data == null) {
        //   //     //     return CircularProgressIndicator();
        //   //     //   } else {
        //   //     //     return ListView.builder(
        //   //     //         itemBuilder: (context, index) => buildCatItem(
        //   //     //             HomeCubit.get(context).categoriesModel.data[index]),
        //   //     //         itemCount:
        //   //     //             HomeCubit.get(context).categoriesModel.data.length);
        //   //     //   }
        //   //     // },
        //   //   ),
        //   // );
        // },
      ),
    );
  }

  Widget item(SubCategoryModel model) => ListView(children: [
        GridView.count(
            // padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
            childAspectRatio: 1 / 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            primary: false,
            children: List.generate(model.data!.length, (index) {
              return InkWell(
                onTap: () {
                  print('fdfdfdfdfdfdf');
                  print('${model.data![index].id}');
                  Navigator.pushNamed(context, SubSubCatScreen.routeName,
                      arguments: RouteArgument(
                        id: model.data![index].id.toString(),
                        param: model.data![index].name.toString(),
                      ));
                },
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                        padding:EdgeInsets.all(30),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(model.data![index].name.toString(),
                                  style: model.data![index].id.toString() ==
                                          model.data!.first.id.toString()
                                      ? TextStyle(
                                          color: mainColorLite,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)
                                      : TextStyle(
                                          color: textDarkColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis)
                            ]))),
              );
              // InkWell(
              //   child: Card(
              //       elevation: 5,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8)),
              //       child: Padding(
              //           padding:
              //               EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceAround,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(model.data![index].name!,

              //                     style: model.selected == true
              //                     ? TextStyle(
              //                         color: mainColorLite,
              //                         fontWeight: FontWeight.w500,
              //                         fontSize: 12)
              //                     :
              //                      TextStyle(
              //                         color: textDarkColor,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     maxLines: 3,
              //                     textAlign: TextAlign.center,
              //                     overflow: TextOverflow.ellipsis)
              //               ]))),
              // );
            })),
        SizedBox(height: 80),
      ]);
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: RegularAppBar(label: widget.routeArgument!.id.toString()),
  //       key: _scaffoldKey,
  //       backgroundColor: Color(0xfff5f5f5),
  //       body: RefreshIndicator(onRefresh: () async {
  //         if (_categories != null) {
  //           // _categories!.clear();
  //           // _categories = null;
  //         }

  //         // _categoryBloc.allPage = 1;
  //         // _categoryBloc.add(FetchCategoriesEvent());
  //       }, child:
  //           BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
  //         if (state is CategoryErrorState) {
  //           _categories = [];
  //           SchedulerBinding.instance?.addPostFrameCallback((_) {
  //             displaySnackBar(title: state.errors, scaffoldKey: _scaffoldKey);
  //           });
  //         }
  //         if (state is CategoriesSuccessState) {
  //           if (_categories == null) {
  //             _categories = [];
  //           } else {}
  //         }
  //         if (state is SubCategoriesSuccessState) {
  //           if (_subCategories == null) {
  //             _subCategories = [];
  //           }
  //           if (_selectedCategory != null &&
  //               state.items != null &&
  //               state.items!.length != 0) {
  //             if (_showRealLength == false) {
  //               SchedulerBinding.instance?.addPostFrameCallback((_) {
  //                 setState(() {
  //                   _showRealLength = true;
  //                 });
  //               });
  //             }
  //             if (_subCategories!.length != 0 &&
  //                 _subCategories!.first.id != state.items!.first.id) {
  //               _subCategories!.addAll(state.items!);
  //             } else if (_subCategories!.length == 0) {
  //               _subCategories!.addAll(state.items!);
  //             }
  //           }
  //         }

  //         return CustomScrollView(
  //             controller: _scrollController,
  //             physics: BouncingScrollPhysics(),
  //             slivers: [
  //               SliverToBoxAdapter(
  //                   child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                     // Expanded(
  //                     //     flex: 3,
  //                     //     child: Container(
  //                     //         padding: EdgeInsets.only(bottom: 40),
  //                     //         decoration: BoxDecoration(
  //                     //             color: Color(0xffffffff),
  //                     //             border: Border.symmetric(
  //                     //                 vertical: BorderSide(
  //                     //                     color: Color(0xffeeeeee)))),
  //                     //         child: _categoryBloc!.categories == null
  //                     //             ? ListView.builder(
  //                     //                 shrinkWrap: true,
  //                     //                 physics: BouncingScrollPhysics(),
  //                     //                 itemCount: 6,
  //                     //                 itemBuilder: (context, index) {
  //                     //                   return CategoryEmptyWidget();
  //                     //                 })
  //                     //             : ListView.builder(
  //                     //                 shrinkWrap: true,
  //                     //                 physics: BouncingScrollPhysics(),
  //                     //                 itemCount:
  //                     //                     _categoryBloc!.categories!.length,
  //                     //                 itemBuilder: (context, index) {
  //                     //                   if (_categoryBloc!
  //                     //                       .categories!.isNotEmpty) {
  //                     //                     return CategoryWidget(
  //                     //                         model: _categoryBloc!
  //                     //                             .categories![index],
  //                     //                         onTap: () => onCategoryTap(
  //                     //                             _categoryBloc!
  //                     //                                 .categories![index]));
  //                     //                   }
  //                     //                   return CategoryEmptyWidget();
  //                     //                 }))),
  //                     // Expanded(
  //                     //     flex: 3,
  //                     //     child: Container(
  //                     //         padding: EdgeInsets.only(bottom: 40),
  //                     //         decoration: BoxDecoration(
  //                     //             color: Color(0xffffffff),
  //                     //             border: Border.symmetric(
  //                     //                 vertical: BorderSide(
  //                     //                     color: Color(0xffeeeeee)))),
  //                     //         child: _categoryBloc!.categories == null
  //                     //             ? ListView.builder(
  //                     //                 shrinkWrap: true,
  //                     //                 physics: BouncingScrollPhysics(),
  //                     //                 itemCount: 6,
  //                     //                 itemBuilder: (context, index) {
  //                     //                   return CategoryEmptyWidget();
  //                     //                 })
  //                     //             : ListView.builder(
  //                     //                 shrinkWrap: true,
  //                     //                 physics: BouncingScrollPhysics(),
  //                     //                 itemCount:
  //                     //                     _categoryBloc!.categories!.length,
  //                     //                 itemBuilder: (context, index) {
  //                     //                   if (_categoryBloc!
  //                     //                       .categories!.isNotEmpty) {
  //                     //                     return CategoryWidget(
  //                     //                         model: _categoryBloc!
  //                     //                             .categories![index],
  //                     //                         onTap: () => onCategoryTap(
  //                     //                             _categoryBloc!
  //                     //                                 .categories![index]));
  //                     //                   }
  //                     //                   return CategoryEmptyWidget();
  //                     //                 }))),
  //                     Expanded(
  //                         flex: 7,
  //                         child: Container(
  //                           padding: EdgeInsets.only(bottom: 30),
  //                           margin: EdgeInsets.only(left: 6, right: 8),
  //                           child: Column(children: [
  //                             _subCategories == null ||
  //                                     _subCategories!.length == 0
  //                                 ? ListView.separated(
  //                                     padding:
  //                                         EdgeInsets.symmetric(vertical: 12),
  //                                     primary: false,
  //                                     shrinkWrap: true,
  //                                     itemCount: 4,
  //                                     itemBuilder:
  //                                         (BuildContext context, int index) {
  //                                       return SubCategoryEmptyWidget();
  //                                     },
  //                                     separatorBuilder:
  //                                         (BuildContext context, int index) =>
  //                                             SizedBox(height: 8))
  //                                 : ListView.separated(
  //                                     padding:
  //                                         EdgeInsets.symmetric(vertical: 12),
  //                                     primary: false,
  //                                     shrinkWrap: true,
  //                                     itemCount: _showRealLength == true
  //                                         ? _subCategories!.length
  //                                         : (_subCategories!.first
  //                                                     .subSubCategory!.length >
  //                                                 6
  //                                             ? 1
  //                                             : 2),
  //                                     itemBuilder:
  //                                         (BuildContext context, int index) {
  //                                       return Stack(
  //                                         alignment: Alignment.bottomRight,
  //                                         children: [
  //                                           SubCategoryWidget(
  //                                               realLength: _showRealSubLengthIndex !=
  //                                                           null &&
  //                                                       _showRealSubLengthIndex ==
  //                                                           index
  //                                                   ? _subCategories![index]
  //                                                       .subSubCategory!
  //                                                       .length
  //                                                   : (_subCategories![index]
  //                                                               .subSubCategory!
  //                                                               .length >
  //                                                           10
  //                                                       ? 10
  //                                                       : (_subCategories![
  //                                                                       index]
  //                                                                   .subSubCategory!
  //                                                                   .length >=
  //                                                               5
  //                                                           ? 5
  //                                                           : 1)),
  //                                               model: _subCategories![index]),
  //                                           if (_subCategories![index]
  //                                                       .subSubCategory!
  //                                                       .length !=
  //                                                   0 &&
  //                                               _subCategories![index]
  //                                                       .subSubCategory!
  //                                                       .length >
  //                                                   3)
  //                                             Align(
  //                                               alignment:
  //                                                   Alignment.bottomRight,
  //                                               child: GestureDetector(
  //                                                   onTap: () async {
  //                                                     setState(() {
  //                                                       _showRealSubLengthIndex =
  //                                                           index;
  //                                                     });
  //                                                   },
  //                                                   child: Container(
  //                                                     color: Colors.white,
  //                                                     margin:
  //                                                         EdgeInsets.symmetric(
  //                                                             horizontal: 15.w,
  //                                                             vertical: 20.h),
  //                                                     child: RichText(
  //                                                       softWrap: true,
  //                                                       maxLines: 2,
  //                                                       textAlign:
  //                                                           TextAlign.center,
  //                                                       text:
  //                                                           TextSpan(children: [
  //                                                         if (_showRealSubLengthIndex !=
  //                                                             index)
  //                                                           TextSpan(
  //                                                             text: translate(
  //                                                                 "button.show_more"),
  //                                                             style: TextStyle(
  //                                                               color: Colors
  //                                                                   .blue
  //                                                                   .withOpacity(
  //                                                                       0.5),
  //                                                               fontWeight:
  //                                                                   FontWeight
  //                                                                       .bold,
  //                                                               decoration:
  //                                                                   TextDecoration
  //                                                                       .underline,
  //                                                               fontSize: 25.sp,
  //                                                             ),
  //                                                           ),
  //                                                         TextSpan(text: " "),
  //                                                       ]),
  //                                                     ),
  //                                                   )),
  //                                             ),
  //                                         ],
  //                                       );
  //                                     },
  //                                     separatorBuilder:
  //                                         (BuildContext context, int index) =>
  //                                             SizedBox(height: 8)),
  //                           ]),
  //                         )),
  //                   ])),
  //             ]);
  //       })));
  // }

  // onCategoryTap(int index) {
  //   selectedIndex = false;
  // }
}
