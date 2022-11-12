import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/blocs/search/search_state.dart';
import 'package:hand_bill/src/data/model/Search_data.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/sub_categoies_screen.dart';

import '../../../../blocs/favorite/favorite_bloc.dart';
import '../../../../blocs/search/search_bloc.dart';
import '../../../../common/constns.dart';
import '../../../../common/global.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../../component/custom/login_first_widget_sliver.dart';
import '../../../component/custom/regular_app_bar.dart';
import '../../details_package/product_details/product_details_screen.dart';
import '../../services_package/patented/patents_screen.dart';
import 'Product_Details.dart';

class SearchByCategoriesScreen extends StatefulWidget {
  const SearchByCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<SearchByCategoriesScreen> createState() =>
      _SearchByCategoriesScreenState();
}

class _SearchByCategoriesScreenState extends State<SearchByCategoriesScreen> {
  late SearchBloc _searchBloc;
  List<Data>? data;
  bool isFetching = false;
  var _scrollController = ScrollController();
  final _searchController = TextEditingController();

  final double size = 20;
  int selectedPage = 0;
  FocusNode focusNode = FocusNode();
  List<Product>? product;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc..add(SearchProductEvent(searchKey: _searchController.text));
    _searchBloc..add(SearchAllCategoriesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitted(value) async {
      if (_searchController.text.length >= 3) {
        if (selectedPage == 0) {
          _searchBloc..add(SearchProductEvent(searchKey: value));
        }
      }
    }

    Color borderColor = Color(0xffeeeeee);

    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: Container(
            width: 370,
            height: 40,
            child: TextField(
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  _onSubmitted(value.trim());
                  _searchBloc
                    ..add(
                        SearchProductEvent(searchKey: _searchController.text));
                },
                style: TextStyle(color: textLiteColor),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset("assets/icons/search_ic.svg",
                            height: size, width: size)),
                    hintText: translate("search.text"),
                    filled: true,
                    focusColor: mainColor,
                    hintStyle: Theme.of(context).textTheme.headline2,
                    fillColor: Color(0xffffffff),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(color: borderColor, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: borderColor, width: 1))),
                controller: _searchController,
                textInputAction: TextInputAction.go,
                onSubmitted: (value) => _onSubmitted(value.trim()),
                focusNode: focusNode),
          )),
      body: SizedBox(
        height: 900,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 690,
            child: BlocConsumer<SearchBloc, SearchState>(
                listener: (context, state) {
              if (state is SearchProductsSuccessState) {
                product = state.products;
              }
              if (state is SearchCategoriesSuccessState) {
                print(state.toString());
                if (state.products!.isEmpty) {
                  data = null;
                } else {
                  data = [];
                  data!.clear();
                  data!.addAll(state.products!);
                  _searchBloc.isFetching = false;
                }
              }
            }, builder: (context, state) {
              return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  controller: _scrollController,
                  slivers: [
                    data == null
                        ? LoadingSliver()
                        : data!.length == 0
                            ? CenterWidgetListSliver(label: "search is empty")
                            : SliverToBoxAdapter(
                                child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Search by Product',
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 165,
                                      child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade500),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ListView.separated(
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SearchProduct(
                                                    product![index]);
                                              },
                                              itemCount: product!.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      Container(
                                                height: 1,
                                                width: double.infinity,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Search by Category',
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 460,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade500),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          height: 400,
                                          width: 520,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SearchCategories(
                                                    model: data![index]);
                                              },
                                              itemCount: data!.length,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ))
                  ]);
            }),
          ),
        ),
      ),
    );
  }

  Widget SearchProduct(Product model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: RouteArgument(param: model));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Container(
            height: 60,
            width: 200,
            child: Row(
              children: [
                // CachedNetworkImage(imageUrl: model.flag),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                        child: CachedNetworkImage(
                            imageUrl: model.images![0].thump!))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    model.name,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class SearchCategories extends StatelessWidget {
  final Data model;
  final bool isHome;

  SearchCategories({required this.model, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      print('omniaaaaaaaaaaaaaaa');
      print(model.id);
      Navigator.pushNamed(context, SubCategoriesScreen.routeName,
          arguments: RouteArgument(param: model.id));
    }, child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          clipBehavior: Clip.antiAlias,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color(0xffeeeeee), width: 1.5),
              boxShadow: [
                BoxShadow(
                    color: Color(0xfff5f5f5), blurRadius: 3, spreadRadius: 3)
              ]),
          child: Row(
            children: [
              Expanded(child: CachedNetworkImage(imageUrl: model.icon!)),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  model.name!,
                  style: TextStyle(color: Colors.black),
                ),
              )),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SubCategoriesScreen.routeName,
                        arguments: RouteArgument(param: model.id));
                  },
                  icon: Icon(Icons.arrow_forward_ios))
            ],
          ));
    }));
  }
}
