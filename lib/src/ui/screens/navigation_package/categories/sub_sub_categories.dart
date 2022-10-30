import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/category/sub_sub.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_sub_category_widget.dart';

import '../../../../data/model/local/route_argument.dart';
import '../../../component/custom/regular_app_bar.dart';
import '../../services_package/shipping/cubit.dart';
import '../../services_package/shipping/states.dart';

class SubSubCatScreen extends StatefulWidget {
  static const routeName = "/subSUBcat";
  late final RouteArgument? routeArgument;
  SubSubCatScreen({required this.routeArgument});
  @override
  State<SubSubCatScreen> createState() => _SubSubCatScreenState();
}

class _SubSubCatScreenState extends State<SubSubCatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShippingBloc()
        ..getSubsubCategories(id: widget.routeArgument?.id.toString()),
      child: BlocConsumer<ShippingBloc, InterState>(
        listener: (context, state) {
          if (state is ShopIntresSuccessStates) {
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          }
          if (state is ShopIntresErrorStates) {
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          }
        },
        builder: (context, state) {
          var model = ShippingBloc.get(context).subsubCategoryModel;
          return Scaffold(
            backgroundColor: Color(0xfff5f5f5),
            appBar:
                RegularAppBar(label: widget.routeArgument!.param.toString()),
            body: ConditionalBuilder(
              condition: ShippingBloc.get(context).subsubCategoryModel != null,
              builder: (context) => item(model!),
              fallback: (context) => Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
        // bui
      ),
    );
  }

  Widget item(SubSubCategoryModel model) => ListView(children: [
        GridView.count(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
            childAspectRatio: 1 / 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            primary: false,
            children: List.generate(model.data!.length, (index) {
              return SubSubCategoryWidget(
                model: model.data![index],
              );
              // InkWell(
              //   child: Card(
              //       elevation: 5,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8)),
              //       child: Padding(
              //           padding:
              //               EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceAround,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(model.data![index].name!,

              //                     style: model.selected == true
              //                     ? TextStyle(
              //                         color: mainColorLite,
              //                         fontWeight: FontWeight.w500,
              //                         fontSize: 12)
              //                     :
              //                      TextStyle(
              //                         color: textDarkColor,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     maxLines: 3,
              //                     textAlign: TextAlign.center,
              //                     overflow: TextOverflow.ellipsis)
              //               ]))),
              // );
            })),
        SizedBox(height: 80),
      ]);
}
