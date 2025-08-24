import 'package:flutter/material.dart';

class Recherche extends StatefulWidget {
  const Recherche({super.key});
  @override
  RechercheState createState() => RechercheState();
}

class RechercheState extends State<Recherche> {
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
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/patcgfwy_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 16,
                                              height: 10,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/sq1vwll6_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              width: 24,
                                              height: 11,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/dwr9j3t3_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                        ]),
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 23, left: 23),
                                        width: 24,
                                        height: 24,
                                        child: Image.network(
                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/jxzsj6hv_expires_30_days.png",
                                          fit: BoxFit.fill,
                                        )),
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
                                            bottom: 37, left: 20, right: 20),
                                        width: double.infinity,
                                        child: Row(children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 21),
                                              width: 18,
                                              height: 18,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/ql610jvf_expires_30_days.png",
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
                                                    hintText: "Poulet",
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
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 17, left: 20),
                                      child: Text(
                                        "12 résultats pour “poulet”",
                                        style: TextStyle(
                                          color: Color(0xFF888888),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 9, left: 20),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    width: 183,
                                                    height: 262,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/lug9vpfg_expires_30_days.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 12),
                                                    width: 182,
                                                    height: 262,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/4wg9ii2f_expires_30_days.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            19),
                                                    color: Color(0xFFFFFFFF),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x00000000),
                                                        blurRadius: 12,
                                                        offset: Offset(0,
                                                            6.394571781158447),
                                                      ),
                                                    ],
                                                  ),
                                                  margin: const EdgeInsets.only(
                                                      top: 12),
                                                  width: 7,
                                                  height: 264,
                                                  child: SizedBox(),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 24,
                                                left: 20,
                                                right: 20),
                                            width: double.infinity,
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                  )
                                                ])))
                                  ]))))
                    ]))));
  }
}
