
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/patents/patents_bloc.dart';
import 'package:hand_bill/src/blocs/patents/patents_event.dart';
import 'package:hand_bill/src/blocs/patents/patents_state.dart';
import 'package:hand_bill/src/data/model/services/patented_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/my_patents_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'component/patented_widget.dart';

import 'package:store_redirect/store_redirect.dart';

class PatentsScreen extends StatefulWidget {
  static const routeName = "/PatentsScreen";

  @override
  _PatentsScreenState createState() => _PatentsScreenState();
}

class _PatentsScreenState extends State<PatentsScreen> {
  List<PatentedModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PatentsBloc _patentsBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;
  User? _user;

  @override
  void initState() {
    _patentsBloc = BlocProvider.of<PatentsBloc>(context);
    _scrollController = ScrollController()..addListener(_onScroll);
    _patentsBloc.allPage = 1;
    _patentsBloc..add(FetchPatentsEvent());
    _user = BlocProvider.of<GlobalBloc>(context).user;

    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController!.position.maxScrollExtent;
    final offset = _scrollController!.offset;

    if (offset + offsetVisibleThreshold >= max && !_patentsBloc.isFetching) {
      setState(() {
        _patentsBloc.isFetching = true;
      });
      _patentsBloc.add(FetchPatentsEvent());
    }
  }

  double iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(
            label: "categories.patented",

                ),
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all( 40.0,),
              child:
               Container(
                 height: 300,
                 width: 300,
                 decoration: BoxDecoration(
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black12,
                       spreadRadius: 7,
                       blurRadius: 8
                     )
                   ],
                   borderRadius: BorderRadius.circular(20),
                   color: Colors.white
                 ),
                    child: Column(
                      children: [
                        Padding(
                                padding:EdgeInsets.all(15),
                             child:  new Text("'if you need to see patents for others you should to be seller,",style: TextStyle(color: Colors.black,fontSize: 30,wordSpacing: 3,),)),

                        TextButton(
                          child: new Text("Be Seller"),
                          onPressed: () async {
                            if (Platform.isIOS) {
                              await canLaunch('') ? launch("") : print("can not open the link");
                            } else {
                              await canLaunch(
                                  'https://play.google.com/store/apps/details?id=gyapp.hand_bill_manger')
                                  ? launch(
                                  "https://play.google.com/store/apps/details?id=com.egyapp.hand_bill_manger")
                                  : print("can not open the link");
                            }
                          },

                        ),
                        TextButton(
                          child: new Text("My Patents",),
                          onPressed: () {
                            Navigator.pushNamed(context, MyPatentsScreen.routeName);                          },
                        ),
                      ],
                    ),
              //    TextButton(
              //   child: new Text("Be Seller"),
              //   onPressed: () async {
              //     if (Platform.isIOS) {
              //       await canLaunch('') ? launch("") : print("can not open the link");
              //     } else {
              //       await canLaunch(
              //           'https://play.google.com/store/apps/details?id=gyapp.hand_bill_manger')
              //           ? launch(
              //           "https://play.google.com/store/apps/details?id=com.egyapp.hand_bill_manger")
              //           : print("can not open the link");
              //     }
              //   },
              //
              // ),
              //        TextButton(
              //             child: new Text("My Patents",),
              //             onPressed: () {
              //               Navigator.pushNamed(context, MyPatentsScreen.routeName);                          },
              //           ),
              //                     ] ),
            )
            )]),
        // body: BlocListener<PatentsBloc, PatentsState>(
        //     listener: (context, state) {
        //       if (state is PatentsErrorState) {
        //         setState(() {
        //           _items = [];
        //         });
        //
        //         displaySnackBar(title: state.error!, scaffoldKey: _scaffoldKey);
        //       }
        //       if (state is PatentsSuccessState) {
        //         setState(() {
        //           if (_items == null) {
        //             _items = [];
        //           }
        //           _items!.addAll(state.items!);
        //         });
        //       }
        //     },
        //     child: RefreshIndicator(
        //         onRefresh: () async {
        //           if (_items != null) {
        //             _items!.clear();
        //             _items = null;
        //           }
        //
        //           _patentsBloc.allPage = 1;
        //           _patentsBloc.add(FetchPatentsEvent());
        //         },
        //         child: CustomScrollView(
        //             physics: BouncingScrollPhysics(),
        //             controller: _scrollController,
        //             slivers: [
        //               _items == null
        //                   ? LoadingSliver()
        //                   : _items!.length == 0
        //                       ? CenterWidgetListSliver(
        //                           label: "Patents is empty")
        //                       : SliverToBoxAdapter(
        //                           child: ListView.separated(
        //                               physics: BouncingScrollPhysics(),
        //                               // padding: EdgeInsets.symmetric(vertical: 16),
        //                               primary: false,
        //                               shrinkWrap: true,
        //                               itemCount: _items!.length,
        //                               scrollDirection: Axis.vertical,
        //                               itemBuilder: (context, index) {
        //                                 return PatentedWidget(
        //                                     model: _items![index]);
        //                               },
        //                               separatorBuilder:
        //                                   (BuildContext context, int index) =>
        //                                       Container(
        //                                           height: 10,
        //                                           color: Color(0xffeeeeee)))),
        //               SliverToBoxAdapter(child: SizedBox(height: 100)),
        //
        //             ]))));
    );
  }
}

class LoadingSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator(strokeWidth: 2)]));
  }
}
