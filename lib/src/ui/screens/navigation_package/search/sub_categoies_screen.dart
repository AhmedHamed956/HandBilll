import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/search/search_state.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/appBar2.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/sub_sub_categorie.dart';

import '../../../../blocs/search/search_bloc.dart';
import '../../../../blocs/search/search_event.dart';
import '../../../../data/model/Search_data.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../../component/custom/login_first_widget_sliver.dart';
import '../../services_package/patented/patents_screen.dart';

class SubCategoriesScreen extends StatefulWidget {
  static const routeName = "/subCategoriesScreen";
  final RouteArgument routeArgument;

  SubCategoriesScreen({
    required this.routeArgument,
  });

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late SearchBloc _searchBloc;
  List<Data>? list;
  late int id;
  var _scrollController = ScrollController();

  @override
  void initState() {
    id = widget!.routeArgument!.param;
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    print(id);
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc..add(SearchAllSubCategoriesEvent(id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },),
        title: Text('Back',style: TextStyle(color: Colors.black),),

      ),
        body: BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {
      if (state is SearchSubCategoriesSuccessState) {
        if (state.subCategories!.isEmpty) {
          list = null;
        } else {
          list = [];
          list!.clear();
          list!.addAll(state.subCategories!);
          _searchBloc.isFetching = false;
        }
      }
    }, builder: (context, state) {
      return CustomScrollView(
          physics: BouncingScrollPhysics(),
          reverse: true,
          controller: _scrollController,
          slivers: [
            list == null
                ? LoadingSliver()
                : list!.length == 0
                    ? CenterWidgetListSliver(label: "search is empty")
                    : SliverToBoxAdapter(
                        child: SizedBox(
                        height: 780,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return SearchCategories(model: list![index]);
                          },
                          itemCount: list!.length,
                        ),
                      )),
          ]);
    }));
  }
}

class SearchCategories extends StatelessWidget {
  final Data model;
  final bool isHome;

  SearchCategories({required this.model, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      print('omnilalalalalaalalalalaaaaaaa');
      print(model.id);
      Navigator.pushNamed(context, SubSubCategories.routeName,
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
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.name!,
                      style: TextStyle(color: Colors.black),
                    )),
              )),
              SizedBox(
                width: 120,
              ),
              IconButton(onPressed: () {Navigator.pushNamed(context, SubSubCategories.routeName,
                  arguments: RouteArgument(param: model.id));}, icon: Icon(Icons.arrow_forward_ios))
            ],
          ));
    }));
  }
}
