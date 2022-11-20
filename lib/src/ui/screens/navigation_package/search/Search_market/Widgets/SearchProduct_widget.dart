
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/model/local/route_argument.dart';
import '../../../../../../data/response/search/search_product_response.dart';
import '../../../../details_package/company/company_screen.dart';

Widget SearchProduct(DataProductSearch model,context) {
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
