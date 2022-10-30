import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hand_bill/src/blocs/notification/notifications_bloc.dart';
import 'package:hand_bill/src/blocs/notification/notifications_event.dart';
import 'package:hand_bill/src/blocs/notification/notifications_state.dart';
import 'package:hand_bill/src/data/model/notification_model.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

import 'component/notification_widget.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = "/notificationScreen";

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  NotificationsBloc? _notificationsBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;

  @override
  void initState() {
    _notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    _notificationsBloc!.page = 1;
    _notificationsBloc!.add(NotificationsFetchEvent());
    _scrollController = ScrollController()..addListener(_onScroll);

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

    if (offset + offsetVisibleThreshold >= max &&
        !_notificationsBloc!.isFetching) {
      setState(() {
        _notificationsBloc!.isFetching = true;
      });
      _notificationsBloc!.add(NotificationsFetchEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(label: "profile.notification"),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_items != null) {
                setState(() {
                  _items!.clear();
                  _items = null;
                });
              }
              _notificationsBloc!.page = 1;
              _notificationsBloc!.add(NotificationsFetchEvent());
            },
            child: BlocListener<NotificationsBloc, NotificationsState>(
                listener: (context, state) {
                  if (state is NotificationsErrorState) {
                    _items = [];

                    displaySnackBar(
                        title: state.error!, scaffoldKey: _scaffoldKey);
                  }
                  if (state is NotificationsSuccessState) {
                    setState(() {
                      if (_items == null) {
                        _items = [];
                      }
                      _items!.addAll(state.items!);
                    });
                  }
                },
                child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      _items == null
                          ? LoadingSliver()
                          : _items!.length == 0
                              ? CenterWidgetListSliver(
                                  label: translate("profile.notification_empty"))
                              : SliverToBoxAdapter(
                                  child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      // padding: EdgeInsets.symmetric(vertical: 16),
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: _items!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return NotificationWidget(
                                            model: _items![index]);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Container(
                                                  height: 10,
                                                  color: Color(0xffeeeeee)))),
                      SliverToBoxAdapter(child: SizedBox(height: 100)),
                      SliverToBoxAdapter(
                          child: Container(
                              child: loading == true
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 40),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2)))
                                  : SizedBox()))
                    ]))));
  }
}
