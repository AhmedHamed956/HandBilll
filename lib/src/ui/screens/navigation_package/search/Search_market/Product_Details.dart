import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';
import 'package:hand_bill/src/data/response/search/search_product_response.dart';

import '../../../../../blocs/favorite/favorite_bloc.dart';
import '../../../../../blocs/favorite/favorite_event.dart';
import '../../../../../blocs/favorite/favorite_state.dart';
import '../../../../../blocs/global_bloc/global_bloc.dart';
import '../../../../../blocs/home/home_bloc.dart';
import '../../../../../blocs/search/search_bloc.dart';
import '../../../../../blocs/search/search_state.dart';
import '../../../../../common/constns.dart';
import '../../../../../data/model/user.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = "/ProductDetalis";
  final RouteArgument routeArgument;

  const ProductDetails({required this.routeArgument});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  User? user;
  HomeBloc? _homeBloc;
  late SearchD product;
  late FavoriteBloc favoriteBloc;

  late SearchBloc _searchBloc;

  @override
  void didChangeDependencies() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    user = BlocProvider.of<GlobalBloc>(context).user;
    product = widget.routeArgument.param;
    print(product.name);
    print(product.id);
    print('sokaaaaaaa');
    super.initState();
  }

  getUser() {
    user = BlocProvider.of<GlobalBloc>(context).user;
    if (user != null) {
      print(user!.name!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is AddToFavoriteSuccessState) {
            _homeBloc!.popularList.forEach((element) {
              if (element.id == state.favoriteId) {
                setState(() {
                  element.isFavourite = true;
                });
              }
            });
            Fluttertoast.showToast(
                msg: state.message ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          if (state is RemoveFromFavoriteSuccessState) {
            _homeBloc!.popularList.forEach((element) {
              if (element.id == state.productId) {
                setState(() {
                  element.isFavourite = false;
                });
              }
            });
            Fluttertoast.showToast(
                msg: state.message ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 500,
                        width: 370,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 3,
                                  blurRadius: 6)
                            ]),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Stack(children: [
                                  Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey)),
                                      child: CachedNetworkImage(
                                          width: 370,
                                          // height: 200,
                                          imageUrl: product!.images!.isEmpty
                                              ? placeholder
                                              : product!.images![0].thump!,
                                          placeholder: (context, url) => Center(
                                              heightFactor: 1,
                                              widthFactor: 1,
                                              child: CircularProgressIndicator(
                                                  color: mainColorLite,
                                                  strokeWidth: 1)),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error,
                                                  color: mainColorLite))),
                                  Positioned(
                                      top: 12,
                                      right: 12,
                                      child: InkWell(
                                          onTap: () {
                                            if (product.isFavourite == false) {
                                              favoriteBloc.add(AddToFavoriteEvent(
                                                  productId: product!.id!,
                                                  user: user!));
                                              setState(() {
                                                product.isFavourite = true;

                                              });
                                              product.isFavourite = true;

                                            } else {
                                              favoriteBloc.add(
                                                  RemoveFromFavoriteEvent(
                                                      user: user!,
                                                      favoriteId: product!.id!));
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 500,
                        width: 370,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 3,
                                  blurRadius: 6)
                            ]),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Stack(children: [
                                  Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey)),
                                      child: CachedNetworkImage(
                                          width: 370,
                                          // height: 200,
                                          imageUrl: product!.images!.isEmpty
                                              ? placeholder
                                              : product!.images![0].thump!,
                                          placeholder: (context, url) => Center(
                                              heightFactor: 1,
                                              widthFactor: 1,
                                              child: CircularProgressIndicator(
                                                  color: mainColorLite,
                                                  strokeWidth: 1)),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error,
                                                  color: mainColorLite))),
                                  Positioned(
                                      top: 12,
                                      right: 12,
                                      child: InkWell(
                                          onTap: () {
                                            if (product.isFavourite == 0) {
                                              favoriteBloc.add(AddToFavoriteEvent(
                                                  productId: product!.id,
                                                  user: user!));
                                              product.isFavourite = 1;
                                            } else {
                                              favoriteBloc.add(
                                                  RemoveFromFavoriteEvent(
                                                      user: user!,
                                                      favoriteId: product.id));

                                              product.isFavourite = false;
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Color(0x80ffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                  border: Border.all(
                                                      color: Color(0x14000000))),
                                              child: Icon(product.isFavourite == false
                                                  ?Icons.favorite_border
                                                  : Icons.favorite_rounded,
                                                  size: 16,
                                                  color: Colors.red)))),
                                ])),
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Name :',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 15,
                                          )),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(product!.name!,
                                          style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                          )),
                                    )),
                              ],
                            ),
                                              product.isFavourite = 0;
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Color(0x80ffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                  border: Border.all(
                                                      color: Color(0x14000000))),
                                              child: Icon(product.isFavourite == 0 ?Icons.favorite_border : Icons.favorite_rounded,
                                                  size: 16,
                                                  color: Colors.red)))),
                                ])),
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Name :',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 15,
                                          )),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(product.name,
                                          style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontSize: 15,
                                          )),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Country :',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 15,
                                          )),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: CachedNetworkImage(
                                    width: 20,
                                    // height: 200,
                                    imageUrl: '${product.flag}',
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ]),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 10),
                              child: Row(children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Price :',
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 15,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('${product.price}\$ ',
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                              ]),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20,left: 10),
                            child: Text(product!.company!.name!,style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 15,)
                                ))
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
