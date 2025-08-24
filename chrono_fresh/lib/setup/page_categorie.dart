import 'package:flutter/material.dart';
class PageDUneCateGorie extends StatefulWidget {
	const PageDUneCateGorie({super.key});
	@override
		PageDUneCateGorieState createState() => PageDUneCateGorieState();
	}
class PageDUneCateGorieState extends State<PageDUneCateGorie> {
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
														padding: const EdgeInsets.only( top: 12, bottom: 12, left: 22, right: 22),
														margin: const EdgeInsets.only( top: 4, bottom: 8),
														width: double.infinity,
														child: Row(
															children: [
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
																	margin: const EdgeInsets.only( right: 6),
																	width: 18,
																	height: 10,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/y2rc2ej1_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
																Container(
																	margin: const EdgeInsets.only( right: 10),
																	width: 16,
																	height: 10,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/lir7hpb2_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
																Container(
																	width: 24,
																	height: 11,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/tmkl1xvu_expires_30_days.png",
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
															margin: const EdgeInsets.only( bottom: 43, left: 23),
															child: Row(
																children: [
																	Container(
																		margin: const EdgeInsets.only( right: 109),
																		width: 24,
																		height: 24,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/gnc6jbi4_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																	Text(
																		"Boucherie",
																		style: TextStyle(
																			color: Color(0xFF181725),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
												),
												Container(
													margin: const EdgeInsets.only( bottom: 21, left: 35),
													child: Text(
														"134 articles",
														style: TextStyle(
															color: Color(0xFF888888),
															fontSize: 12,
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 24, left: 20, right: 20),
														width: double.infinity,
														child: Row(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Container(
																	margin: const EdgeInsets.only( right: 8),
																	width: 183,
																	height: 262,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/j3gtxa86_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
																Container(
																	width: 182,
																	height: 262,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/vluid9k0_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 24, left: 20, right: 20),
														width: double.infinity,
														child: Row(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Container(
																	margin: const EdgeInsets.only( right: 8),
																	width: 183,
																	height: 262,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/jo5xh3vh_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
																Container(
																	width: 182,
																	height: 262,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/3fjl1p0i_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 56),
														width: double.infinity,
														child: Stack(
															clipBehavior: Clip.none,
															children: [
																Row(
																	mainAxisAlignment: MainAxisAlignment.center,
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		Container(
																			margin: const EdgeInsets.only( right: 8),
																			width: 183,
																			height: 262,
																			child: Image.network(
																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/luxhd5ym_expires_30_days.png",
																				fit: BoxFit.fill,
																			)
																		),
																		Container(
																			width: 182,
																			height: 262,
																			child: Image.network(
																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/x9rn60gs_expires_30_days.png",
																				fit: BoxFit.fill,
																			)
																		),
																	])])))]))))]))));}}