import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/search/search_bloc.dart';
import '../../../../blocs/search/search_event.dart';
import '../../../../data/model/Search_data.dart';
import '../../../../data/model/local/route_argument.dart';

class SubCategoriesScreen extends StatefulWidget {
  static const routeName = "/subCategoriesScreen";
  final RouteArgument routeArgument;
  final int? id;

  SubCategoriesScreen({required this.routeArgument,  this.id});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late SearchBloc _searchBloc;
  List<Data>? data;
  @override
  void initState() {
    print('llllllllllllll');
    print(widget!.id);
    print(widget!.id);
    print(widget!.id);
    print(widget!.id);
    print(widget!.id);
    print(widget!.id);
    print(widget!.id);
    print(widget!.id);
    print(widget!.id);
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc..add(SearchAllSubCategoriesEvent(id: widget!.id!));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
