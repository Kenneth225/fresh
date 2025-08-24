import 'package:flutter/material.dart';
class PageProduit extends StatefulWidget {
	const PageProduit({super.key});
	@override
		PageProduitState createState() => PageProduitState();
	}
class PageProduitState extends State<PageProduit> {
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
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												IntrinsicHeight(
													child: Container(
														padding: const EdgeInsets.only( top: 4, bottom: 33),
														margin: const EdgeInsets.only( bottom: 24),
														width: double.infinity,
														decoration: BoxDecoration(
															image: DecorationImage(
																image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/tn2myrtt_expires_30_days.png"),
																fit: BoxFit.cover
															),
														),
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																IntrinsicHeight(
																	child: Container(
																		padding: const EdgeInsets.only( top: 12, bottom: 12, left: 22, right: 22),
																		margin: const EdgeInsets.only( bottom: 8),
																		width: double.infinity,
																		child: Row(
																			children: [
																				Expanded(
																					child: Container(
																						width: double.infinity,
																						child: Text(
																							"9:41",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 14,
																								fontWeight: FontWeight.bold,
																							),
																							textAlign: TextAlign.center,
																						),
																					),
																				),
																				Container(
																					margin: const EdgeInsets.only( right: 6),
																					width: 18,
																					height: 10,
																					child: Image.network(
																						"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/m1cts580_expires_30_days.png",
																						fit: BoxFit.fill,
																					)
																				),
																				Container(
																					margin: const EdgeInsets.only( right: 10),
																					width: 16,
																					height: 10,
																					child: Image.network(
																						"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/ury94xs8_expires_30_days.png",
																						fit: BoxFit.fill,
																					)
																				),
																				Container(
																					width: 24,
																					height: 11,
																					child: Image.network(
																						"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/rk7x6sl5_expires_30_days.png",
																						fit: BoxFit.fill,
																					)
																				),
																			]
																		),
																	),
																),
																IntrinsicWidth(
																	child: IntrinsicHeight(
																		child: Container(
																			margin: const EdgeInsets.only( bottom: 52, left: 23),
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						margin: const EdgeInsets.only( left: 1),
																						width: 10,
																						height: 18,
																						child: Image.network(
																							"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/nqdw6yi0_expires_30_days.png",
																							fit: BoxFit.fill,
																						)
																					),
																					Container(
																						width: 24,
																						height: 24,
																						child: Image.network(
																							"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/oqadbiph_expires_30_days.png",
																							fit: BoxFit.fill,
																						)
																					),
																				]
																			),
																		),
																	),
																),
																IntrinsicHeight(
																	child: Container(
																		width: double.infinity,
																		child: Column(
																			children: [
																				IntrinsicWidth(
																					child: IntrinsicHeight(
																						child: Container(
																							padding: const EdgeInsets.only( left: 123, right: 123),
																							child: Row(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									Container(
																										decoration: BoxDecoration(
																											borderRadius: BorderRadius.circular(13),
																											color: Color(0xFF006650),
																										),
																										margin: const EdgeInsets.only( top: 203, right: 4),
																										width: 15,
																										height: 2,
																										child: SizedBox(),
																									),
																									Container(
																										decoration: BoxDecoration(
																											borderRadius: BorderRadius.circular(13),
																											color: Color(0xFFB3B3B3),
																										),
																										margin: const EdgeInsets.only( top: 203, right: 4),
																										width: 3,
																										height: 2,
																										child: SizedBox(),
																									),
																									Container(
																										decoration: BoxDecoration(
																											borderRadius: BorderRadius.circular(13),
																											color: Color(0xFFB3B3B3),
																										),
																										margin: const EdgeInsets.only( top: 203),
																										width: 3,
																										height: 2,
																										child: SizedBox(),
																									),
																								]
																							),
																						),
																					),
																				),
																			]
																		),
																	),
																),
															]
														),
													),
												),
												Container(
													margin: const EdgeInsets.only( bottom: 9, left: 25),
													child: Text(
														"Nom du produit",
														style: TextStyle(
															color: Color(0xFF181725),
															fontSize: 24,
															fontWeight: FontWeight.bold,
														),
													),
												),
												Container(
													margin: const EdgeInsets.only( bottom: 24, left: 25),
													child: Text(
														"Prix au kg",
														style: TextStyle(
															color: Color(0xFF7C7C7C),
															fontSize: 16,
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 30, left: 25, right: 25),
														width: double.infinity,))]))))]))));}}