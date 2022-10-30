import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';

class ShippingWidget extends StatelessWidget {
  final ServiceCategoryModel model;
  final Function onTap;

  ShippingWidget({required this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => onTap(),
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.image == ''
                        ? Container(
                            // height: 50,
                            // width: 50,
                            child: Image.asset(
                              "assets/images/Hbill.jpeg",
                              height: 60,
                            ),
                          )
                        : Image.network(
                            model.image.toString(),
                            height: 40,
                          ),
                    Text(model.name.toString(),
                        style: model.selected == true
                            ? TextStyle(
                                color: mainColorLite,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)
                            : TextStyle(
                                color: textDarkColor,
                                fontWeight: FontWeight.w500,
                              ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis)
                  ]))),
    );

    // InkWell(
    //     onTap: () => onTap(),
    //     child: Container(
    //         // height: size.height * 0.1,
    //         decoration: BoxDecoration(
    //           color: Color(0xfff5f5f5),

    //           // model.selected == true ? Color(0xfffafafa) : Colors.white
    //         ),
    //         child: Column(children: [
    //           Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    //               child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Icon(
    //                       Icons.add_circle_rounded,
    //                       color: Colors.green,
    //                     ),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text(model.name!,
    //                         style: model.selected == true
    //                             ? TextStyle(
    //                                 color: mainColorLite,
    //                                 fontWeight: FontWeight.w500,
    //                                 fontSize: 12)
    //                             : TextStyle(color: textDarkColor, fontSize: 12),
    //                         maxLines: 3,
    //                         textAlign: TextAlign.center,
    //                         overflow: TextOverflow.ellipsis)
    //                   ])),
    //           // model.selected == true
    //           //     ? Container(width: 3, color: mainColorLite)
    //           //     : SizedBox(),
    //         ])));
  }
}
