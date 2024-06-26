import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/chats/conversition_model.dart';
import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/services/assets_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/expandable_text.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AssetsDetailsScreen extends StatefulWidget {
  static const routeName = "/AssetsDetailsScreen";
  final RouteArgument routeArgument;

  AssetsDetailsScreen({required this.routeArgument});

  @override
  _AssetsDetailsScreenState createState() => _AssetsDetailsScreenState();
}

class _AssetsDetailsScreenState extends State<AssetsDetailsScreen> {
  late AssetsModel _model;
  double _marginVer = 16;

  int _imageIndex = 0;
  User? _user;
  ConversationModel? _conversation;
  List<ChatUser> _users = [];

  @override
  void initState() {
    _model = widget.routeArgument.param;
    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user != null) {
      // _users.add(ChatUser(
      //     id: _user!.id,
      //     name: _user!.name,
      //     email: _user!.email,
      //     deviceToken: _user!.deviceToken,
      //     thumb: placeholder));
      // _users.add(ChatUser(
      //     id: _model.company!.id,
      //     name: _model.company!.name,
      //     email: _model.company!.email,
      //     deviceToken: _model.company!.deviceToken,
      //     thumb: _model.company!.logo!.url));
      // _conversation = ConversationModel(users: _users);
    }
    super.initState();
  }
  bool showContact = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
        appBar: RegularAppBar(label: "Assets Details"),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: mainColor,
        //     onPressed: () {
        //       if (_user == null) {
        //         Fluttertoast.showToast(msg: "login first");
        //       } else {
        //         // Navigator.pushNamed(context, InboxScreen.routeName,
        //         //     arguments: RouteArgument(param: _conversation));
        //       }
        //     },
        //     child: Icon(Icons.chat_outlined, color: Colors.white)),
        body: Stack(
          children: [
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        SizedBox(
                            height: height,
                            width: double.infinity,
                            child: PageView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: _model.images == null
                                    ? 1
                                    : _model.images!.length,
                                scrollDirection: Axis.horizontal,
                                controller: PageController(viewportFraction: 1),
                                onPageChanged: (int index) {
                                  setState(() => _imageIndex = index);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, ImageFullScreen.routeName,
                                          arguments: RouteArgument(
                                            param: _model.images![index].url,
                                          )),
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: _model.images![index].url!,
                                          placeholder: (context, url) => FittedBox(
                                              child: Transform.scale(
                                                  scale: 0.2,
                                                  child: CircularProgressIndicator(
                                                      color: mainColorLite,
                                                      strokeWidth: 2))),
                                          errorWidget: (context, url, error) =>
                                          new Image.asset("assets/images/hb_logo.jpeg",
                                            fit: BoxFit.contain,)));
                                })),
                        Positioned(
                            bottom: 8,
                            right: 0,
                            left: 0,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DotsIndicator(
                                      dotsCount: _model.images == null
                                          ? 1
                                          : _model.images!.length,
                                      position: _imageIndex.toDouble(),
                                      decorator: DotsDecorator(
                                          color: Color(0x4DFFFFFF),
                                          activeColor: Color(0xB3FFFFFF),
                                          size: const Size.square(4.0),
                                          activeSize: const Size(10.0, 4.0),
                                          activeShape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(5.0))))
                                ])),
                      ]),
                      SizedBox(height: 8),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: _marginVer * 0.5),
                                Text(_model.title ?? "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                                SizedBox(height: _marginVer),
                                ExpandableTextWidget(text: _model.description!),
                                _divider(),
                                InkWell(
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, CompanyScreen.routeName,
                                      //     arguments:
                                      //         RouteArgument(param: Market()));
                                    },
                                    child: SizedBox(
                                        height: 160.h,
                                        child: Row(children: [
                                          AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image:
                                                          CachedNetworkImageProvider(
                                                              _model
                                                                  .company!
                                                                  .logo!
                                                                  .url!),
                                                          fit: BoxFit.cover),
                                                      color: Color(0xffffffff),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                      border: Border.all(
                                                          color:
                                                          Color(0xffe0e0e0))))),
                                          SizedBox(width: 16),
                                          Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Seller",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: textDarkColor,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                               SizedBox(
                                                 height: 92.h,
                                                 width: 610.w,
                                                 child:  Text(_model.company!.name!,
                                                     maxLines: 2,
                                                     style: TextStyle(
                                                       fontSize: 15,
                                                       overflow: TextOverflow.ellipsis,
                                                       color: textDarkColor,
                                                     )),
                                               ),
                                              ]),
                                        ]))),
                                // SizedBox(height: _marginVer),
                                _divider(),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Price : ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold)),
                                                Text("${_model.price} \$",
                                                    style: TextStyle(
                                                        color: textLiteColor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold)),
                                              ])),
                                      SizedBox(width: 8),
                                      Expanded(
                                          child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Property type : ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold)),
                                                Expanded(
                                                    child: Text(
                                                        "${_model.propertyType}",
                                                        style: TextStyle(
                                                            color: textLiteColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.bold)))
                                              ]))
                                    ]),
                                SizedBox(height: 8),
                                Row(children: [
                                  Expanded(
                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Phone : ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(width: 4),
                                            Expanded(
                                                child: Text(
                                                    "${_model.company!.firstPhone}",
                                                    style: TextStyle(
                                                        color: textLiteColor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold)))
                                          ]))
                                ]),
                                SizedBox(height: 8),
                                Row(children: [
                                  Expanded(
                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Location : ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(width: 4),
                                            Expanded(
                                                child: Text("${_model.location}",
                                                    style: TextStyle(
                                                        color: textLiteColor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold)))
                                          ]))
                                ]),
                                SizedBox(height: 200)
                              ]))
                    ])),
            Positioned(
              bottom: 70.h,
              right: 30.w,
              child:   InkWell(
                onTap: (){
                  setState(() {
                    showContact = !showContact;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(showContact?Icons.close:Icons.chat,size: 60.w,
                    color: Colors.white,),
                ),
              ),),
            if(showContact==true)...[
              Positioned(
                bottom: 500.h,
                right: 30.w,
                child:  Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      if (_user == null) {
                        Fluttertoast.showToast(msg: translate("toast.login"));
                      }else{
                        if (_model.company!.deviceToken != null){
                          //?text=${Uri.parse(description)}
                          await canLaunch("https://wa.me/+2${_model.company!.leftDataOfCompanies!.firstMobile!=null&&
                            _model.company!.leftDataOfCompanies!.firstMobile!=''?
                        _model.company!.leftDataOfCompanies!.firstMobile:
                        _model.company!.firstPhone}")?
                          launch("https://wa.me/+2${_model.company!.leftDataOfCompanies!.firstMobile!=null&&
                            _model.company!.leftDataOfCompanies!.firstMobile!=''?
                        _model.company!.leftDataOfCompanies!.firstMobile:
                        _model.company!.firstPhone}")
                              :print("cannot launch");
                        }
                      }
                    },
                    color: Colors.transparent,
                    icon: Image.asset("assets/icons/whatsappp.png",
                      height: 100.h,width: 100.w,fit: BoxFit.cover,),),
                ),),
              Positioned(
                bottom: 360.h,
                right: 30.w,
                child:  Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      if (_user == null) {
                        Fluttertoast.showToast(msg: translate("toast.login"));
                      }else{
                        if (_model.company!.deviceToken != null){
                          await canLaunch("tel:${_model.company!.leftDataOfCompanies!.firstMobile!=null&&
                            _model.company!.leftDataOfCompanies!.firstMobile!=''?
                        _model.company!.leftDataOfCompanies!.firstMobile:
                        _model.company!.firstPhone}")?
                          launch("tel:${_model.company!.leftDataOfCompanies!.firstMobile!=null&&
                            _model.company!.leftDataOfCompanies!.firstMobile!=''?
                        _model.company!.leftDataOfCompanies!.firstMobile:
                        _model.company!.firstPhone}")
                              :print("cannot launch");
                        }
                      }
                    },
                    color: Colors.white,
                    icon: Icon(Icons.phone,size: 60.w,),),
                ),),
              Positioned(
                bottom: 220.h,
                right: 30.w,
                child: Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                    onPressed: ()async{
                      if (_user == null) {
                        Fluttertoast.showToast(msg: translate("toast.login"));
                      }else{
                        final Uri params = Uri(
                          scheme: 'mailto',
                          path: '${_model.company!.email}',
                          query: 'subject=Hand bill request &body=description',
                        );
                        final url = params.toString();
                        await canLaunch("$url")?
                        launch("$url"):
                        print("can not open gmail");
                      }
                    },
                    color: Colors.white,
                    icon: Icon(Icons.email,size: 60.w,),),
                ),
              ),
            ],
          ],
        )
    );
  }

  Widget _divider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        width: double.infinity,
        height: 2,
        color: Color(0xffeeeeee));
  }
}
