import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/home/banner.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/common/services_company/services_company_details_screen.dart';
import 'package:hand_bill/src/ui/screens/details_package/company/company_screen.dart';

class SliderWidget extends StatelessWidget {
  final BannerModel model;

  SliderWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (model.company!.natureActivity == "Supplier") {
            Navigator.pushNamed(context, CompanyScreen.routeName,
                arguments: RouteArgument(param: model.company!.id));
          } else {
            Navigator.pushNamed(context, ServicesCompanyDetailsScreen.routeName,
                arguments: RouteArgument(param: model.company!.id));
          }
        },
        child: CachedNetworkImage(
            imageUrl: model.image!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
                heightFactor: 1,
                widthFactor: 1,
                child: CircularProgressIndicator(
                    color: mainColorLite, strokeWidth: 1)),
            errorWidget: (context, url, error) =>
                new Icon(Icons.error, color: mainColorLite)));
  }
}
