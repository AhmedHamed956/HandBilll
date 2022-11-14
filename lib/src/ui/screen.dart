import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hand_bill/src/blocs/Companies/bloc.dart';
import 'package:hand_bill/src/blocs/search/search_state.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/category/sub_sub.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';

import '../blocs/Services/Event.dart';
import '../blocs/Services/bloc.dart';
import '../blocs/Services/states.dart';
import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../common/constns.dart';
import '../data/model/company.dart';

class SearchSuppliers extends StatefulWidget {

  @override
  State<SearchSuppliers> createState() => _SearchSuppliersState();
}

class _SearchSuppliersState extends State<SearchSuppliers> {
  ServiceBlocData? serviceBloc;
  SearchBloc? searchBloc;
  FocusNode focusNode = FocusNode();
  List<ServiceModel>? items;
  final _searchController = TextEditingController();
  final double size = 20;
  int selectedPage = 0;
  List<Company>? companies;

  @override
  void initState() {
    serviceBloc = BlocProvider.of<ServiceBlocData>(context);
    serviceBloc!.add(FetchData());
    serviceBloc!.add(SearchMarketEvent(searchKey: _searchController.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitted(value) async {
      if (_searchController.text.length >= 3) {
        if (selectedPage == 0) {
          serviceBloc!..add(SearchMarketEvent(searchKey: value));
        }
      }
    }

    Color borderColor = Color(0xffeeeeee);

    return Scaffold(
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
                  serviceBloc!
                    ..add(SearchMarketEvent(searchKey: _searchController.text));
                },
                style: TextStyle(color: textLiteColor),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset("assets/icons/search_ic.svg",
                            height: size, width: size)),
                    hintText: translate("search.suppliers"),
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
      body: BlocConsumer<ServiceBlocData, ServiceState>(
          listener: (context, state) {
        // if(state is)
        if (state is categorySuccessState) {
          items = state.items;
          print('yaraaaaab');
        }
        if (state is searchSuccess) {
          companies = state.company;
          print('fdfdfdfffffffffsssssss');
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              companies == null
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              border: Border.all(color: Colors.black26)),
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                SearchCompany(companies![index]),
                            itemCount: companies!.length,
                            separatorBuilder:
                                (BuildContext context, int index) => Container(
                              height: 1,
                              width: 20,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                    ),
              items == null
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                      child: SizedBox(
                        height: 480,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Colors.black26)),
                            child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  ServiceCompany(items![index]),
                              itemCount: items!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ]),
          ),
        );
      }),
    );
  }
}

Widget ServiceCompany(ServiceModel model) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0,left: 10),
    child: InkWell(onTap: () {
      print('omniaaaaaaaaaaaaaaa');
      print(model.id);
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
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                //      child:  CachedNetworkImage(
                // width: 370,
                //     // height: 200,
                //     imageUrl: model!.image!,
                //     placeholder: (context, url) => Center(
                //         heightFactor: 1,
                //         widthFactor: 1,
                //         child: CircularProgressIndicator(
                //             color: mainColorLite,
                //             strokeWidth: 1)),
                //     errorWidget: (context, url, error) =>
                //     new Icon(Icons.error,
                //         color: mainColorLite))),
                Expanded(
                  child: Text(
                    model.name,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,color: Colors.black26,)
              ],
            ),
          ));
    })),
  );
}

Widget SearchCompany(Company model) {
  return InkWell(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
          child:  CachedNetworkImage(
              width: 370,
              // height: 200,
              imageUrl: placeholder,
              placeholder: (context, url) => Center(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: CircularProgressIndicator(
                      color: mainColorLite,
                      strokeWidth: 1)),
              errorWidget: (context, url, error) =>
              new Icon(Icons.error,
                  color: mainColorLite))),

          SizedBox(
            width: 10,
          ),
          //      child:  CachedNetworkImage(
          // width: 370,
          //     // height: 200,
          //     imageUrl: model!.image!,
          //     placeholder: (context, url) => Center(
          //         heightFactor: 1,
          //         widthFactor: 1,
          //         child: CircularProgressIndicator(
          //             color: mainColorLite,
          //             strokeWidth: 1)),
          //     errorWidget: (context, url, error) =>
          //     new Icon(Icons.error,
          //         color: mainColorLite))),
          Text(
            model.name,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    ),
  );
}
