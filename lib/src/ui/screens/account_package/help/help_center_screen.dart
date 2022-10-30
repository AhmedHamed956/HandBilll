import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatefulWidget {
  static const routeName = "/HelpCenterScreen";

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegularAppBar(label: "Help Center"),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              ContactWidget(
                  text: "HAND BILL SELLERS", email: "Seller@hand-bill.com"),
              ContactWidget(
                  text: "AUCTION ROOM", email: "Auction@hand-bill.com"),
              ContactWidget(
                  text: "SPONSORED", email: "Sponsored@hand-bill.com"),
              ContactWidget(
                  text: "TECHNICAL SUPPORT", email: "Support@hand-bill.com"),
              ContactWidget(
                  text: "HAND BILL FRANCHISE",
                  email: "Franchise@hand-bill.com"),
              ContactWidget(
                  text: "GENERAL REQUIREMENT", email: "Info@hand-bill.com"),
            ])));
  }
}

class ContactWidget extends StatelessWidget {
  final String text;
  final String email;

  ContactWidget({required this.text, required this.email});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => launchEmailSubmission(email),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(text,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          SizedBox(height: 16),
                          Text(email,
                              style: TextStyle(fontSize: 16, color: mainColor))
                        ]),
                    Icon(
                      Icons.email,
                      color: Color(0xffBDBDBD),
                      // color: mainColor,
                    )
                  ])),
          Container(
              height: 6, decoration: BoxDecoration(color: Color(0xffeeeeee)))
        ]));
  }

  void launchEmailSubmission(String email) async {
    final Uri params = Uri(scheme: 'mailto', path: email, queryParameters: {
      // 'subject': 'Default Subject',
      // 'body': 'Default body'
    });
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
