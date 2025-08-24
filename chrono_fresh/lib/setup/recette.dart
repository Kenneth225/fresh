import 'package:flutter/material.dart';
class Recette extends StatefulWidget {
	const Recette({super.key});
	@override
		RecetteState createState() => RecetteState();
	}
class RecetteState extends State<Recette> {
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
														margin: const EdgeInsets.only( bottom: 21),
														width: double.infinity,
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																IntrinsicHeight(
																	child: Container(
																		padding: const EdgeInsets.only( top: 4, bottom: 737),
																		width: double.infinity,
																		decoration: BoxDecoration(
																			image: DecorationImage(
																				image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/6sqt2ddm_expires_30_days.png"),
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
																										"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/lqgbqi1g_expires_30_days.png",
																										fit: BoxFit.fill,
																									)
																								),
																								Container(
																									margin: const EdgeInsets.only( right: 10),
																									width: 16,
																									height: 10,
																									child: Image.network(
																										"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/fgorzltn_expires_30_days.png",
																										fit: BoxFit.fill,
																									)
																								),
																								Container(
																									width: 24,
																									height: 11,
																									child: Image.network(
																										"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/eqrwagsz_expires_30_days.png",
																										fit: BoxFit.fill,
																									)
																								),
																							]
																						),
																					),
																				),
																				Container(
																					margin: const EdgeInsets.only( left: 23),
																					width: 24,
																					height: 24,
																					child: Image.network(
																						"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/jtj7zcsq_expires_30_days.png",
																						fit: BoxFit.fill,
																					)
																				),
																			]
																		),
																	),
																),
																IntrinsicHeight(
																	child: Container(
																		padding: const EdgeInsets.symmetric(vertical: 36),
																		width: double.infinity,
																		decoration: BoxDecoration(
																			image: DecorationImage(
																				image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/hj2ey9xl_expires_30_days.png"),
																				fit: BoxFit.cover
																			),
																		),
																		child: Column(
																			crossAxisAlignment: CrossAxisAlignment.start,
																			children: [
																				IntrinsicHeight(
																					child: Container(
																						margin: const EdgeInsets.only( bottom: 14, left: 27, right: 27),
																						width: double.infinity,
																						child: Row(
																							children: [
																								Expanded(
																									child: Container(
																										width: double.infinity,
																										child: Text(
																											"Pâte à crêpes",
																											style: TextStyle(
																												color: Color(0xFF0A2533),
																												fontSize: 23,
																												fontWeight: FontWeight.bold,
																											),
																										),
																									),
																								),
																								Container(
																									margin: const EdgeInsets.only( right: 6),
																									width: 22,
																									height: 22,
																									child: Image.network(
																										"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/q14mdbpx_expires_30_days.png",
																										fit: BoxFit.fill,
																									)
																								),
																								Text(
																									"45 Min",
																									style: TextStyle(
																										color: Color(0xFF748189),
																										fontSize: 15,
																									),
																								),
																							]
																						),
																					),
																				),
																				InkWell(
																					onTap: () { print('Pressed'); },
																					child: IntrinsicHeight(
																						child: Container(
																							decoration: BoxDecoration(
																								borderRadius: BorderRadius.circular(64),
																								color: Color(0xFFFFFFFF),
																								boxShadow: [
																									BoxShadow(
																										color: Color(0x05000000),
																										blurRadius: 4,
																										offset: Offset(0, 4),
																									),
																								],
																							),
																							padding: const EdgeInsets.symmetric(vertical: 6),
																							margin: const EdgeInsets.only( bottom: 19, left: 19, right: 19),
																							width: double.infinity,
																							child: Column(
																								children: [
																									IntrinsicWidth(
																										child: IntrinsicHeight(
																											child: Container(
																												decoration: BoxDecoration(
																													borderRadius: BorderRadius.circular(64),
																													color: Color(0xFFFFFFFF),
																												),
																												padding: const EdgeInsets.only( top: 8, bottom: 8, left: 49, right: 49),
																												child: Column(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children: [
																														Text(
																															"Ingrédients",
																															style: TextStyle(
																																color: Color(0xFF006650),
																																fontSize: 14,
																															),
																														),]))))]))))])))])))]))))]))));
                                                        
                                                        
                                                        
                                                        }}