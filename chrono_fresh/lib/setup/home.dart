import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
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
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(16),
                                            bottomLeft: Radius.circular(16),
                                          ),
                                          color: Color(0xFF006650),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 4, bottom: 45),
                                        margin:
                                            const EdgeInsets.only(bottom: 31),
                                        width: double.infinity,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              IntrinsicHeight(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12,
                                                          bottom: 12,
                                                          left: 22,
                                                          right: 22),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 29),
                                                  width: double.infinity,
                                                  child: Row(children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "9:41",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 6),
                                                        width: 18,
                                                        height: 10,
                                                        child: Image.network(
                                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/toy9w6cx_expires_30_days.png",
                                                          fit: BoxFit.fill,
                                                        )),
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        width: 16,
                                                        height: 10,
                                                        child: Image.network(
                                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/lfnve5dk_expires_30_days.png",
                                                          fit: BoxFit.fill,
                                                        )),
                                                    Container(
                                                        width: 24,
                                                        height: 11,
                                                        child: Image.network(
                                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/f3g7115g_expires_30_days.png",
                                                          fit: BoxFit.fill,
                                                        )),
                                                  ]),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 24,
                                                    left: 20,
                                                    right: 246),
                                                child: Text(
                                                  "Bonjour John,",
                                                  style: TextStyle(
                                                    color: Color(0xFFFFFFFF),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              IntrinsicHeight(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16,
                                                          bottom: 16,
                                                          left: 8,
                                                          right: 8),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  width: double.infinity,
                                                  child: Row(children: [
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        width: 16,
                                                        height: 16,
                                                        child: Image.network(
                                                          "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/cullvjdo_expires_30_days.png",
                                                          fit: BoxFit.fill,
                                                        )),
                                                    Expanded(
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 1),
                                                          width:
                                                              double.infinity,
                                                          child: TextField(
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF656565),
                                                              fontSize: 14,
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                textField1 =
                                                                    value;
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Recherchez votre produit",
                                                              isDense: true,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              0),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(0xFFD7E7E4),
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 43,
                                                left: 20,
                                                right: 20),
                                            width: double.infinity,
                                            child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 24),
                                                      child: Row(children: [
                                                        Expanded(
                                                            child: IntrinsicHeight(
                                                                child: Container(
                                                                    margin: const EdgeInsets.only(right: 12),
                                                                    width: double.infinity,
                                                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                      Container(
                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                10),
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          "Des promotions\nà croquer",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF006650),
                                                                            fontSize:
                                                                                26,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            print('Pressed');
                                                                          },
                                                                          child: IntrinsicWidth(
                                                                              child: IntrinsicHeight(
                                                                                  child: Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(43),
                                                                              color: Color(0xFF006650),
                                                                            ),
                                                                          ))))
                                                                    ]))))
                                                      ]))
                                                ])))
                                  ]))))
                    ]))));
  }
}
