import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});
  @override
  ExploreState createState() => ExploreState();
}

class ExploreState extends State<Explore> {
  String textField1 = '';
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
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/gm2c9ixv_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 16,
                                              height: 10,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/d008l6ka_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              width: 24,
                                              height: 11,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/1itb41np_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                        ]),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 29, left: 144),
                                      child: Text(
                                        "Catégories",
                                        style: TextStyle(
                                          color: Color(0xFF181725),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(0xFFF1F2F2),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 17,
                                            bottom: 17,
                                            left: 15,
                                            right: 15),
                                        margin: const EdgeInsets.only(
                                            bottom: 32, left: 25, right: 25),
                                        width: double.infinity,
                                        child: Row(children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 18,
                                              height: 18,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/zclo07pw_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Expanded(
                                            child: IntrinsicHeight(
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: double.infinity,
                                                child: TextField(
                                                  style: TextStyle(
                                                    color: Color(0xFF7C7C7C),
                                                    fontSize: 14,
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      textField1 = value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Recherchez un produit",
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 161,
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
                                                          const EdgeInsets.only(
                                                              bottom: 24),
                                                      width: double.infinity,
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
                                                                "FRUITS & L&GUMES",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF006650),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            IntrinsicHeight(
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                child: Row(
                                                                    children: [
                                                                      Container(
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              right:
                                                                                  16),
                                                                          width:
                                                                              73,
                                                                          height:
                                                                              56,
                                                                          child:
                                                                              Image.network(
                                                                            "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/4ey670i0_expires_30_days.png",
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          )),
                                                                      Container(
                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                1,
                                                                            right:
                                                                                12),
                                                                        child:
                                                                            Text(
                                                                          "Fruits et légumes ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF0F0F0F),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                          width:
                                                                              24,
                                                                          height:
                                                                              24,
                                                                          child:
                                                                              Image.network(
                                                                            "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/hvrylegj_expires_30_days.png",
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          )),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  )
                                                ])))
                                  ]))))
                    ]))));
  }
}
