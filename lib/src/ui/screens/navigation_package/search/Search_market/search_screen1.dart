
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
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/company_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/Search_market/sub_categoies_screen.dart';

import '../../../../../blocs/favorite/favorite_bloc.dart';
import '../../../../../blocs/search/search_bloc.dart';
import '../../../../../common/constns.dart';
import '../../../../../common/global.dart';
import '../../../../../data/model/local/route_argument.dart';
import '../../../../../data/model/local/tab_toggle_model.dart';
import '../../../../../data/response/search/search_product_response.dart';
import '../../../../component/custom/custom_tab_toggle.dart';
import '../../../../component/custom/login_first_widget_sliver.dart';
import '../../../../component/custom/regular_app_bar.dart';
import '../../../details_package/product_details/product_details_screen.dart';
import '../../../services_package/patented/patents_screen.dart';
import '../search_service/company_service_screen.dart';
import 'Product_Details.dart';

class SearchByCategoriesScreen extends StatefulWidget {
  const SearchByCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<SearchByCategoriesScreen> createState() =>
      _SearchByCategoriesScreenState();
}

class _SearchByCategoriesScreenState extends State<SearchByCategoriesScreen> {
  late SearchBloc _searchBloc;
  List<SearchData>? data;
  bool isFetching = false;
  var _scrollController = ScrollController();
  final _searchController = TextEditingController();
  List<TabToggleModel> labelList = [
    TabToggleModel(label: translate("search.products")),
    TabToggleModel(label: translate("search.suppliers"))
  ];
  bool gridOrList = true;


  final double size = 20;
  int selectedPage = 0;
  FocusNode focusNode = FocusNode();
  List<DataProductSearch>? product;
  List<DataCompanySearch>? companyy;
  getRecentSearch() async {
    try{
      recentSearchProduct = await storage.read(key: "recentSearchProduct");
      recentSearchMarket = await storage.read(key: "recentSearchMarket");
      if (recentSearchProduct == null) {
        _searchBloc..add(SearchProductEvent(searchKey: ""));
      } else {
        _searchBloc..add(SearchProductEvent(searchKey: recentSearchProduct));
      }
      if (recentSearchMarket == null) {
        // _searchBloc..add(SearchMarketEvent(searchKey: ""));
        // } else {
        //   _searchBloc..add(SearchMarketEvent(searchKey: recentSearchMarket));
      }
    }catch(e){print(e.toString());}
  }

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    // _searchBloc..add(SearchProductEvent(searchKey: _searchController.text));
    _searchBloc..add(SearchAllCategoriesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitted(value) async {
      if (_searchController.text.length >= 2) {
        if (selectedPage == 0) {
          _searchBloc..add(SearchProductEvent(searchKey: value));
        }
        if(selectedPage == 1){
          _searchBloc..add(SearchComEvent(searchKey: value));

        }
        if(product!.isEmpty){
          product!.clear();
          product = null;
        }else if(companyy!.isEmpty){
          companyy!.clear();
          companyy = null;
        }
      // }
    }}

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
                controller : _searchController,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  _onSubmitted(value);
                  if(_searchController!.text.isEmpty!){
                    setState(() {
                      product!.clear();
                       companyy!.clear();
                    });
                  }
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
                textInputAction: TextInputAction.go,
                onSubmitted: (value) => _onSubmitted(value.trim()),
                focusNode: focusNode),
          )),
      body: SizedBox(
        height: 900,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTabToggle(
                  items: labelList,
                  initIndex: selectedPage,
                  onIndexChanged: (index) {
                    setState(() {
                      selectedPage = index;
                      print(selectedPage);
                    });
                  }),
              SizedBox(
                height: 600,
                child:
                    BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {
                  if (state is SearchProductsSuccessState) {
                  if (state.products!.products!.data!.isEmpty!) {
                    product = null;
                  } else {
                    product = [];
                    product!.clear();
                    product = state!.products!.products!.data!;
                    _searchBloc.isFetching = false;
                  }
                  product = state!.products!.products!.data!;
                  }
                  if(state is SearchcompanySuccessState){
                    print('yaaaaraaaab');
                    print(state.products!.companies!.data![0].name);
                    if (state.products!.companies!.data!.isEmpty!) {
                      companyy = null;
                    } else {
                      companyy = [];
                      companyy!.clear();
                      companyy = state!.products!.companies!.data!;
                      _searchBloc.isFetching = false;
                    }
                    companyy = state!.products!.companies!.data!;
                    companyy = state.products!.companies!.data;
                    print(companyy);
                    print('yaaaaraaaab');

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
                  return SingleChildScrollView(
                    child: SafeArea(
                        child:
                        Column(
                          children: [
                            Column(
                              children: [
                                selectedPage ==0
                               ? Column(children: [

                                  _searchController.text.isEmpty && selectedPage == 0
                                   ?Container(
                                        height: 10,
                                  )
                                  :   product == null
                                  ? Container(
                                     height: 100,
                                    width: 400,
                                    child:  Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.search_off_sharp,color: Colors.red,size: 30,),
                                          Text('Search is empty',style: TextStyle(fontSize: 20,color: Colors.black54),),
                                        ],
                                    ),
                                  )
                                  :
                                  SizedBox(
                                        height: 130,
                                        child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              color: Colors.white38,
                                              child: ListView.separated(
                                                itemBuilder: (BuildContext context, int index) {
                                                  return SearchProduct(product![index]);
                                                },
                                                itemCount: product!.length,
                                                separatorBuilder: (BuildContext context, int index) =>
                                                    Container(
                                                      height: 1,
                                                      width: double.infinity,
                                                      color: Colors.grey.shade300,
                                                    ),
                                              ),
                                            ))),
                                  Container(width: double.infinity,
                                    height: 1,
                                    color: Colors.grey.shade300,),
                      ])
                                    : Column(children: [

                                  _searchController.text.isEmpty && selectedPage == 1
                                      ?Container(
                                    height: 10,
                                  )
                                      :   companyy == null
                                      ? Container(
                                    height: 100,
                                    width: 400,
                                    child:  Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.search_off_sharp,color: Colors.red,size: 30,),
                                        Text('Search is empty',style: TextStyle(fontSize: 20,color: Colors.black54),),
                                      ],
                                    ),
                                  )
                                      :
                                  SizedBox(
                                      height: 130,
                                      child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            color: Colors.white38,
                                            child: ListView.separated(
                                              itemBuilder: (BuildContext context, int index) {
                                                return SearchCompany(companyy![index]);
                                              },
                                              itemCount: companyy!.length,
                                              separatorBuilder: (BuildContext context, int index) =>
                                                  Container(
                                                    height: 1,
                                                    width: double.infinity,
                                                    color: Colors.grey.shade300,
                                                  ),
                                            ),
                                          ))),
                                  Container(width: double.infinity,
                                    height: 1,
                                    color: Colors.grey.shade300,),
                                ])
                              ],
                            ),


                            data == null
                        ? CircularProgressIndicator()
                        : data!.length == 0
                            ? CenterWidgetListSliver(label: "search is empty")
                            : Column(
                              children: [
                                SizedBox(
                                  child: Padding(
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
                                ),

                                SizedBox(
                                    height: 630,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(

                                        height: 600,
                                        width: 520,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView.builder(
                                            itemBuilder: (BuildContext context, int index) {
                                              return SearchCategories(model: data![index]);
                                            },
                                            itemCount: data!.length,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),

                  ])));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SearchProduct(DataProductSearch model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CompanyScreen.routeName,
            arguments: RouteArgument(param: model));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 5,left: 20),
        child: Container(
            height: 30,
            width: 200,
            child:
                // CachedNetworkImage(imageUrl: model.flag),
                // Padding(
                //     padding: EdgeInsets.all(10),
                //     child: Container(
                //         child: CachedNetworkImage(
                //             imageUrl: model.images![0].thump!))),
                Text(
                    model.name!,
                    style: TextStyle(color: Colors.black54, fontSize: 15),

            )),
      ),
    );
  }
  Widget SearchCompany(DataCompanySearch model) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CompanyServiceScreen.routeName,
            arguments: RouteArgument(param: model.id));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
        child: Container(
            height: 60,
            width: 200,
            child: Row(
              children: [
                // CachedNetworkImage(imageUrl: model.flag),
                // Padding(
                //     padding: EdgeInsets.all(10),
                //     child: Container(
                //         child: CachedNetworkImage(
                //             imageUrl: model.company!.images![0].thump!))),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    model.name!,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),
              ],
            )),
      ),
    );
  }

}

class SearchCategories extends StatelessWidget {
  final SearchData model;
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
