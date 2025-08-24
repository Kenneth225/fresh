import 'package:flutter/material.dart';

class PanierStep2 extends StatefulWidget {
  const PanierStep2({super.key});
  @override
  PanierStep2State createState() => PanierStep2State();
}

class PanierStep2State extends State<PanierStep2> {
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
                              color: Color(0xFF006650),
                              width: double.infinity,
                              height: double.infinity,
                              child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    IntrinsicHeight(
                                        child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 16),
                                            width: double.infinity,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 22),
                                                    child: Text(
                                                      "9:41",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  IntrinsicHeight(
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 26),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            1,
                                                                        left:
                                                                            23),
                                                                    width: 15,
                                                                    height: 15,
                                                                    child: Image
                                                                        .network(
                                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/arx77s12_expires_30_days.png",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )),
                                                                IntrinsicHeight(
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            52),
                                                                    width: double
                                                                        .infinity,
                                                                    child: Column(
                                                                        children: [
                                                                          Text(
                                                                            "Mon panier",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xFF181725),
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          24,
                                                                      left: 20),
                                                                  child: Text(
                                                                    "2 articles",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF000000),
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                                IntrinsicHeight(
                                                                    child: Container(
                                                                        margin: const EdgeInsets.only(bottom: 409, left: 20, right: 20),
                                                                        width: double.infinity,
                                                                        child: Column(children: [
                                                                          IntrinsicHeight(
                                                                              child: Container(
                                                                                  margin: const EdgeInsets.only(bottom: 25),
                                                                                  width: double.infinity,
                                                                                  child: Row(children: [
                                                                                    Container(
                                                                                        margin: const EdgeInsets.only(right: 6),
                                                                                        width: 68,
                                                                                        height: 57,
                                                                                        child: Image.network(
                                                                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/hgo6neun_expires_30_days.png",
                                                                                          fit: BoxFit.fill,
                                                                                        )),
                                                                                    Expanded(
                                                                                        child: IntrinsicHeight(
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                          Container(
                                                                                            margin: const EdgeInsets.only(bottom: 1),
                                                                                            width: double.infinity,
                                                                                            child: Text(
                                                                                              "Les steaks hachés façon bouchère",
                                                                                              style: TextStyle(
                                                                                                color: Color(0xFF000000),
                                                                                                fontSize: 14,
                                                                                              ),
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            margin: const EdgeInsets.only(bottom: 3),
                                                                                            child: Text(
                                                                                              "456 F FCA Pièce (820g) (5678 F FCA/kg)",
                                                                                              style: TextStyle(
                                                                                                color: Color(0xFF000000),
                                                                                                fontSize: 10,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          IntrinsicWidth(
                                                                                            child: IntrinsicHeight(
                                                                                              child: Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  border: Border.all(
                                                                                                    color: Color(0xFF006650),
                                                                                                    width: 1,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(50),
                                                                                                  color: Color(0xFF006650),
                                                                                                ),
                                                                                                padding: const EdgeInsets.only(left: 5, right: 1),
                                                                                                child: Row(children: [
                                                                                                  Container(
                                                                                                      margin: const EdgeInsets.only(right: 11),
                                                                                                      width: 6,
                                                                                                      height: 1,
                                                                                                      child: Image.network(
                                                                                                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/7dw1rkjg_expires_30_days.png",
                                                                                                        fit: BoxFit.fill,
                                                                                                      )),
                                                                                                  IntrinsicWidth(
                                                                                                    child: IntrinsicHeight(
                                                                                                      child: Container(
                                                                                                        margin: const EdgeInsets.only(right: 5),
                                                                                                        child: Column(children: [
                                                                                                          Text(
                                                                                                            "1",
                                                                                                            style: TextStyle(
                                                                                                              color: Color(0xFFFFFFFF),
                                                                                                              fontSize: 8,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ]),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Container(
                                                                                                      width: 16,
                                                                                                      height: 16,
                                                                                                      child: Image.network(
                                                                                                        "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/kx6sa6ms_expires_30_days.png",
                                                                                                        fit: BoxFit.fill,
                                                                                                      )),
                                                                                                ]),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ]),
                                                                                      ),
                                                                                    ))
                                                                                  ])))
                                                                        ])))
                                                              ])))
                                                ])))
                                  ]))))
                    ]))));
  }
}
