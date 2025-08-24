import 'package:flutter/material.dart';
class Screen2 extends StatefulWidget {
	const Screen2({super.key});
	@override
		Screen2State createState() => Screen2State();
	}
class Screen2State extends State<Screen2> {
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
									color: Color(0xFFFCFCFC),
									width: double.infinity,
									height: double.infinity,
									child: SingleChildScrollView(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 76),
														width: double.infinity,
														child: Stack(
															clipBehavior: Clip.none,
															children: [
																Column(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		IntrinsicHeight(
																			child: Container(
																				padding: const EdgeInsets.only( top: 382, bottom: 42),
																				width: double.infinity,
																				decoration: BoxDecoration(
																					image: DecorationImage(
																						image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/z8ytp8lu_expires_30_days.png"),
																						fit: BoxFit.cover
																					),
																				),
																				child: Column(
																					children: [
																						Text(
																							"CHRONOFRESH",
																							style: TextStyle(
																								color: Color(0xFF000000),
																								fontSize: 35,
																							),
																						),
																					]
																				),
																			),
																		),
																	]
																),
																Positioned(
																	bottom: 0,
																	left: 68,
																	right: 68,
																	height: 84,
																	child: Container(
																		transform: Matrix4.translationValues(0, 71, 0),
																		child: Container(
																			width: double.infinity,
																			child: Text(
																				"Vos courses à portée de clic",
																				style: TextStyle(
																					color: Color(0xFF006650),
																					fontSize: 39,
																				),
																				textAlign: TextAlign.center,
																			),
																		),
																	),
																),
															]
														),
													),
												),
												Container(
													margin: const EdgeInsets.only( bottom: 38),
													child: Text(
														"Livraison à domicile",
														style: TextStyle(
															color: Color(0xFF000000),
															fontSize: 18,
														),
													),
												),
												InkWell(
													onTap: () { print('Pressed'); },
													child: IntrinsicHeight(
														child: Container(
															decoration: BoxDecoration(
																borderRadius: BorderRadius.circular(100),
																color: Color(0xFF006650),
															),
															padding: const EdgeInsets.symmetric(vertical: 16),
															margin: const EdgeInsets.only( bottom: 225, left: 24, right: 24),
															width: double.infinity,
															child: Column(
																children: [
																	Text(
																		"Faites vos courses",
																		style: TextStyle(
																			color: Color(0xFFFFFFFF),
																			fontSize: 18,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
												),
											],
										)
									),
								),
							),
						],
					),
				),
			),
		);
	}
}