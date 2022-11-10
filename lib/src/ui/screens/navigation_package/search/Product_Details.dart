import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/search/search_event.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/product.dart';

import '../../../../blocs/search/search_bloc.dart';
import '../../../../blocs/search/search_state.dart';
import '../../../../common/constns.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = "/ProductDetalis";
  final RouteArgument routeArgument;
  const ProductDetails({ required this.routeArgument}) ;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  late Product product;
  String? isfavourite ;
  late SearchBloc _searchBloc;
  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);

    product = widget.routeArgument.param;
    print(product.name);
    print(product.id);
    print('sokaaaaaaa');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<SearchBloc, SearchState>(
  listener: (context, state) {
      if(state is isFavouriteSuccessState){
        print('omnia');
        isfavourite = state.num;
        print('object');
        print(isfavourite);
        print('object');
      }
  },
  builder: (context, state) {
    return SafeArea(
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
                boxShadow: [BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 3,
                    blurRadius: 6
                )]
            ),
            child:
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                       border: Border.all(
                         color: Colors.grey
                       )
                      ),
                      child: CachedNetworkImage(
                        width: 370,
                        // height: 200,
                        imageUrl: placeholder,
                      ),
                    )),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Align(alignment: Alignment.centerLeft,child: Text('Country :',style: TextStyle(color: Colors.grey.shade700,fontSize: 20,)),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: CachedNetworkImage(
                              width: 30,
                              // height: 200,
                              imageUrl: '${product.flag}',
                            ),
                          ),
                          SizedBox(width: 10,),
                        ]),
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(alignment: Alignment.centerLeft,child: Text('Name :',style: TextStyle(color: Colors.grey.shade700,fontSize: 20,)),
                          )),
                      Padding(padding: EdgeInsets.all(15),

                          child: Align(alignment: Alignment.centerLeft,child: Text(product.name,style: TextStyle(color: Colors.grey.shade800,fontSize: 20,)),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Align(alignment: Alignment.centerLeft,child: Text('Price :',style: TextStyle(color: Colors.grey.shade700,fontSize: 20,))),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(alignment: Alignment.centerLeft,child: Text('${product.price}\$ ',style: TextStyle(color: Colors.grey.shade800,fontSize: 20,)),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        IconButton(onPressed: (){
                          _searchBloc..add(isFavourite(num: isfavourite));
                          print(isfavourite);
                        }, icon:  Icon( isfavourite == '1' ? Icons.favorite_border :Icons.favorite,color: Colors.red,))
                      ],
                    ),
                  ),
                ],
              )),
          ),

          ],
        ),
      );
  },
),
    );
  }
}
