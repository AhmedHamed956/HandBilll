import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/blocs/search/search_state.dart';
import 'package:hand_bill/src/data/model/Search_data.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/sub_categoies_screen.dart';

import '../../../../blocs/favorite/favorite_bloc.dart';
import '../../../../blocs/search/search_bloc.dart';
import '../../../../common/constns.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../../component/custom/regular_app_bar.dart';
import '../../details_package/product_details/product_details_screen.dart';

class SearchByCategoriesScreen extends StatefulWidget {
  const SearchByCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<SearchByCategoriesScreen> createState() =>
      _SearchByCategoriesScreenState();
}

class _SearchByCategoriesScreenState extends State<SearchByCategoriesScreen> {
  late SearchBloc _searchBloc;
    List<Data> ?data;
  late FavoriteBloc _favoriteBloc;
  bool isFetching = false;


  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc..add(SearchAllCategoriesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xfffafafa),
        appBar: RegularAppBar(
          label: "search.search",
          widget: InkWell(
            onTap: () {
              setState(() {

              });
            },
            child: Container(
              padding: EdgeInsets.all(12),),),),
        body:
        BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {

    if (state is SearchCategoriesSuccessState) {
    print(state.toString());
    if (state.products!.isEmpty) {
      data = null;
    } else {
      data = [];
      data!.clear();
      data!.addAll(state.products!);
      _searchBloc.isFetching = false;

    }}},
          builder: (context, state) {
            return ListView.builder(itemBuilder: (BuildContext context, int index){
              return SearchCategories(model: data![index]);
            });
          }
        )
            );
  }
}
class SearchCategories extends StatelessWidget {
  final Data model;
  final bool isHome;

  SearchCategories(
      {required this.model,
        this.isHome = false});

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
              clipBehavior: Clip.hardEdge,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffeeeeee), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xfff5f5f5), blurRadius: 3, spreadRadius: 3)
                  ]),
              child: Row(
                children: [
                  Expanded(child:
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(model.name!,style: TextStyle(color: Colors.black),)),
                  )),
                  SizedBox(
                    width: 120,
                  ),

                 IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                ],
              )
              );
        }));
  }
}

