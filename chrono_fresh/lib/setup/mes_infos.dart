import 'package:flutter/material.dart';

class MesInfos extends StatefulWidget {
  const MesInfos({super.key});
  @override
  MesInfosState createState() => MesInfosState();
}

class MesInfosState extends State<MesInfos> {
  String textField1 = '';
  String textField2 = '';
  String textField3 = '';
  String textField4 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                constraints: const BoxConstraints.expand(),
                color: Color(0xFFFFFFFF),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                              color: Color(0xFFFFFFFF),
                              width: double.infinity,
                              height: double.infinity,
                              child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    IntrinsicHeight(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 22,
                                            right: 22),
                                        margin: const EdgeInsets.only(
                                            top: 4, bottom: 8),
                                        width: double.infinity,
                                        child: Row(children: [
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              child: Text(
                                                "9:41",
                                                style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 6),
                                              width: 18,
                                              height: 10,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/1erftjyo_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 16,
                                              height: 10,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/f7270qin_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              width: 24,
                                              height: 11,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/ldbaqae7_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                        ]),
                                      ),
                                    ),
                                    IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 17, left: 23),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 71),
                                                    width: 24,
                                                    height: 24,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/942ov805_expires_30_days.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                Container(
                                                  width: 168,
                                                  child: Text(
                                                    "Mes informations personnelles",
                                                    style: TextStyle(
                                                      color: Color(0xFF181725),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 37),
                                        width: double.infinity,
                                        child: Column(children: [
                                          IntrinsicWidth(
                                            child: IntrinsicHeight(
                                              child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Column(children: [
                                                      Container(
                                                          width: 99,
                                                          height: 100,
                                                          child: Image.network(
                                                            "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/h4q66vbp_expires_30_days.png",
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ]),
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      width: 32,
                                                      height: 32,
                                                      child: Container(
                                                          width: 32,
                                                          height: 32,
                                                          child: Image.network(
                                                            "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/7thej9js_expires_30_days.png",
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 24,
                                                left: 23,
                                                right: 23),
                                            width: double.infinity,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IntrinsicHeight(
                                                      child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 12),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              8),
                                                                  child: Text(
                                                                    "Nom prénom",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF0F0F0F),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                IntrinsicHeight(
                                                                    child: Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Color(0xFFEAE4E4),
                                                                            width:
                                                                                1,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(128),
                                                                        ),
                                                                        padding: const EdgeInsets.only(top: 14, bottom: 14, left: 24, right: 48),
                                                                        width: double.infinity,
                                                                        child: TextField(
                                                                            style: TextStyle(
                                                                          color:
                                                                              Color(0xFF7C7C7C),
                                                                          fontSize:
                                                                              12,
                                                                        ))))
                                                              ])))
                                                ])))
                                  ]))))
                    ]))));
  }
}
