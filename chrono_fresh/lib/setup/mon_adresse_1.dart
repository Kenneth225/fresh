import 'package:flutter/material.dart';

class MonAdresse1 extends StatefulWidget {
  const MonAdresse1({super.key});
  @override
  MonAdresse1State createState() => MonAdresse1State();
}

class MonAdresse1State extends State<MonAdresse1> {
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
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/zm31wr7q_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 16,
                                              height: 10,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/4wq8nslw_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                          Container(
                                              width: 24,
                                              height: 11,
                                              child: Image.network(
                                                "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/pox9722l_expires_30_days.png",
                                                fit: BoxFit.fill,
                                              )),
                                        ]),
                                      ),
                                    ),
                                    IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 63, left: 23),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 91),
                                                    width: 24,
                                                    height: 24,
                                                    child: Image.network(
                                                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/qmhekdtn_expires_30_days.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 11),
                                                  child: Text(
                                                    "Mes adresses",
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
                                    IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 596, left: 19),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IntrinsicWidth(
                                                  child: IntrinsicHeight(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 27),
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
                                                                "John DOE",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF000000),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 112,
                                                              child: Text(
                                                                "23 rue des lilas75009 Paris",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF000000),
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                IntrinsicWidth(
                                                  child: IntrinsicHeight(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 1),
                                                      child: Row(children: [
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 4),
                                                            width: 29,
                                                            height: 29,
                                                            child:
                                                                Image.network(
                                                              "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/673dn7nu_expires_30_days.png",
                                                              fit: BoxFit.fill,
                                                            )),
                                                        Text(
                                                          "Ajouter une adresse",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF000000),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 1),
                                        width: double.infinity,
                                        child: Column(children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Color(0xFF000000),
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 7, vertical: 3),
                                            width: 134,
                                            height: 5,
                                            child: SizedBox(),
                                          ),
                                        ]),
                                      ),
                                    )
                                  ]))))
                    ]))));
  }
}
