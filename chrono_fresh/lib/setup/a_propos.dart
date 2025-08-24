import 'package:flutter/material.dart';

class APropos extends StatefulWidget {
  const APropos({super.key});
  @override
  AProposState createState() => AProposState();
}

class AProposState extends State<APropos> {
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
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/a8lum5kn_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 16,
                                              height: 10,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/npcycl89_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              width: 24,
                                              height: 11,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/1nhyjf3h_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                        ]),
                                      ),
                                    ),
                                    IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 30, left: 23),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 115),
                                                    width: 24,
                                                    height: 24,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/ln2i7rsf_expires_30_days.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 11),
                                                  child: Text(
                                                    "À propos",
                                                    style: TextStyle(
                                                      color: Color(0xFF181725),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 18,
                                                left: 24,
                                                right: 24),
                                            width: double.infinity,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: Text(
                                                      "PROFIL",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF006650),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  IntrinsicHeight(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      width: double.infinity,
                                                      child: Row(children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 1,
                                                                  right: 12),
                                                          child: Text(
                                                            "Notifications",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF0F0F0F),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        IntrinsicWidth(
                                                          child:
                                                              IntrinsicHeight(
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                color: Color(
                                                                    0xFFECECEC),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 2,
                                                                      bottom: 2,
                                                                      left: 2,
                                                                      right:
                                                                          26),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                        color: Color(
                                                                            0xFFFFFFFF),
                                                                      ),
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      child:
                                                                          SizedBox(),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                  IntrinsicHeight(
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8),
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8),
                                                          width:
                                                              double.infinity,
                                                          child: Row(children: [
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 1,
                                                                      right:
                                                                          12),
                                                              child: Text(
                                                                "Localiser",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF0F0F0F),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            IntrinsicWidth(
                                                                child:
                                                                    IntrinsicHeight(
                                                                        child:
                                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                color: Color(
                                                                    0xFF006650),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 2,
                                                                      bottom: 2,
                                                                      left: 26,
                                                                      right: 2),
                                                            )))
                                                          ])))
                                                ])))
                                  ]))))
                    ]))));
  }
}
