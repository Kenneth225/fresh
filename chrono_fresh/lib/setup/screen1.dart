import 'package:flutter/material.dart';
class Screen1 extends StatefulWidget {
	const Screen1({super.key});
	@override
		Screen1State createState() => Screen1State();
	}
class Screen1State extends State<Screen1> {
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
														padding: const EdgeInsets.only( top: 382, bottom: 42),
														margin: const EdgeInsets.only( bottom: 419),
														width: double.infinity,
														decoration: BoxDecoration(
															image: DecorationImage(
																image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/ud8579tg_expires_30_days.png"),
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