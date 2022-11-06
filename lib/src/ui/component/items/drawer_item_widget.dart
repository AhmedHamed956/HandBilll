import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/drawer_model.dart';
import 'package:hand_bill/src/data/response/account/account_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_bill/src/ui/component/items/To%20Be%20Seller.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/my_handmade_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/my_patents_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/global_bloc/global_bloc.dart';
import '../../../common/global.dart';
import '../../screens/account_package/agents/agents_screen.dart';
import '../../screens/account_package/help/help_center_screen.dart';
import '../../screens/account_package/wishlist/wishlist_screen.dart';
import '../../screens/auth/auth_screen.dart';
import '../../screens/navigation_package/navigation_screen.dart';
import '../../screens/services_package/asstes/assets_screen.dart';
import '../../screens/services_package/auctions/auctions_screen.dart';
import '../../screens/services_package/hand_made/hand_made_screen.dart';
import '../../screens/services_package/jobs/companies_jobs_screen.dart';
import '../../screens/services_package/offers/offers_screen.dart';
import '../../screens/services_package/patented/patents_screen.dart';

class DrawerItemWidget extends StatelessWidget {
  final Pages model;
  DrawerItemWidget({required this.model});

  final double icSize = 32;

  @override
  Widget build(BuildContext context) {
    bool lang = true;
    return InkWell(
        onTap: () async {
          if (model.title.toString() == 'To Be Seller') {
            if (Platform.isIOS) {
              await canLaunch('') ? launch("") : print("can not open the link");
            } else {
              await canLaunch(
                      'https://play.google.com/store/apps/details?id=gyapp.hand_bill_manger')
                  ? launch(
                      "https://play.google.com/store/apps/details?id=com.egyapp.hand_bill_manger")
                  : print("can not open the link");
            }
          }

          if (model.title.toString() == 'Change Language') {
            if (lang == true) {
              lang = false;
            } else {
              lang = true;
            }
            await changeLocale(context,
                translate('button.ok').trim() == 'ok' ? 'ar' : 'en_US');
            Navigator.pushReplacementNamed(context, NavigationScreen.routeName);
            // ignore: dead_code

          }

          if (model.title.toString() == 'LogOut') {
            BlocProvider.of<GlobalBloc>(context).user = null;
            storage.deleteAll();
            Navigator.pushReplacementNamed(context, AuthScreen.routeName);
          }
          model.title.toString() == 'Help Center'
              ? Navigator.of(context).pushNamed(HelpCenterScreen.routeName)
              : model.title.toString() == 'Wish List'
                  ? Navigator.of(context).pushNamed(WishListScreen.routeName)
                  : model.title.toString() == 'Offers'
                      ? Navigator.of(context).pushNamed(OffersScreen.routeName)
                      : model.title.toString() == 'Auctions'
                          ? Navigator.of(context)
                              .pushNamed(AuctionsScreen.routeName)
                          : model.title.toString() == 'Assets'
                              ? Navigator.of(context)
                                  .pushNamed(AssetsScreen.routeName)
                              : model.title.toString() == 'Patented'
                                  ? Navigator.of(context)
                                      .pushNamed(PatentsScreen.routeName)
                                  : model.title.toString() == 'Jobs'
                                      ? Navigator.of(context).pushNamed(
                                          CompaniesJobsScreen.routeName)
                                      : model.title.toString() == 'Hand Made'
                                          ? Navigator.of(context).pushNamed(
                                              HandmadeScreen.routeName)
                                          : model.title.toString() == 'Agents'
                                              ? Navigator.of(context).pushNamed(
                                                  AgentsScreen.routeName)
                                              : Container();
        },
        child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      model.title.toString() == 'Help Center'
                          ? Image.asset(
                              'assets/icons/account/help.png',
                              // "assets/icons/account/wishlist.svg",
                              height: icSize,
                              width: icSize,
                              fit: BoxFit.cover,
                            )
                          : model.title.toString() == 'Wish List'
                              ? SvgPicture.asset(
                                  'assets/icons/account/wishlist.svg',
                                  // "assets/icons/account/wishlist.svg",
                                  height: icSize,
                                  width: icSize,
                                  fit: BoxFit.cover,
                                )
                              : model.title.toString() == 'Offers'
                                  ? SvgPicture.asset(
                                      'assets/icons/account/sale_tag.svg',
                                      // "assets/icons/account/wishlist.svg",
                                      height: icSize,
                                      width: icSize,
                                      fit: BoxFit.cover,
                                    )
                                  : model.title.toString() == 'Auctions'
                                      ? SvgPicture.asset(
                                          'assets/icons/account/auction.svg',
                                          // "assets/icons/account/wishlist.svg",
                                          height: icSize,
                                          width: icSize,
                                          fit: BoxFit.cover,
                                        )
                                      : model.title.toString() == 'Assets'
                                          ? SvgPicture.asset(
                                              'assets/icons/account/asset.svg',
                                              // "assets/icons/account/wishlist.svg",
                                              height: icSize,
                                              width: icSize,
                                              fit: BoxFit.cover,
                                            )
                                          : model.title.toString() == 'Patented'
                                              ? SvgPicture.asset(
                                                  'assets/icons/account/certificate.svg',
                                                  // "assets/icons/account/wishlist.svg",
                                                  height: icSize,
                                                  width: icSize,
                                                  fit: BoxFit.cover,
                                                )
                                              : model.title.toString() == 'Jobs'
                                                  ? SvgPicture.asset(
                                                      'assets/icons/account/job_search.svg',
                                                      // "assets/icons/account/wishlist.svg",
                                                      height: icSize,
                                                      width: icSize,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : model.title.toString() ==
                                                          'Hand Made'
                                                      ? SvgPicture.asset(
                                                          'assets/icons/account/handmade.svg',
                                                          // "assets/icons/account/wishlist.svg",
                                                          height: icSize,
                                                          width: icSize,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : model.title
                                                                  .toString() ==
                                                              'To Be Seller'
                                                          ? SvgPicture.asset(
                                                              'assets/icons/account/asset.svg',
                                                              // "assets/icons/account/wishlist.svg",
                                                              height: icSize,
                                                              width: icSize,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : model.title
                                                                      .toString() ==
                                                                  'Agents'
                                                              ? SvgPicture
                                                                  .asset(
                                                                  'assets/icons/account/customer_service.svg',
                                                                  // "assets/icons/account/wishlist.svg",
                                                                  height:
                                                                      icSize,
                                                                  width: icSize,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : model.title
                                                                          .toString() ==
                                                                      'Change Language'
                                                                  ? Image.asset(
                                                                      'assets/icons/language.png',
                                                                      // "assets/icons/account/wishlist.svg",
                                                                      height:
                                                                          icSize,
                                                                      width:
                                                                          icSize,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : model.title
                                                                              .toString() ==
                                                                          'LogOut'
                                                                      ? SvgPicture
                                                                          .asset(
                                                                          'assets/icons/account/arrow.svg',
                                                                          // "assets/icons/account/wishlist.svg",
                                                                          height:
                                                                              icSize,
                                                                          width:
                                                                              icSize,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )
                                                                      : Container(),
                      // model.icon!.endsWith(".svg")
                      //     ? SvgPicture.asset(model.icon!,
                      //         height: icSize, width: icSize)
                      //     : Image.asset(model.icon!,
                      //         height: icSize, width: icSize, fit: BoxFit.cover),
                      lang == true
                          ? Text((model.title.toString()),
                              style: TextStyle(
                                  color: textDarkColor,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2)
                          : Text((model.titleAr.toString()),
                              style: TextStyle(
                                  color: textDarkColor,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2)
                    ]))));
  }
}
