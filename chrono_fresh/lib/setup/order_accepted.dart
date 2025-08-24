import 'package:flutter/material.dart';
class OrderAccepted extends StatefulWidget {
	const OrderAccepted({super.key});
	@override
		OrderAcceptedState createState() => OrderAcceptedState();
	}
class OrderAcceptedState extends State<OrderAccepted> {
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
														width: double.infinity,
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Container(
																	height: 477,
																	width: double.infinity,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/m5v3xbvv_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
																IntrinsicHeight(
																	child: Container(
																		padding: const EdgeInsets.only( top: 460, bottom: 54),
																		width: double.infinity,
																		decoration: BoxDecoration(
																			image: DecorationImage(
																				image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/it42fept_expires_30_days.png"),
																				fit: BoxFit.cover
																			),
																		),
																		child: Column(
																			crossAxisAlignment: CrossAxisAlignment.start,
																			children: [
																				Container(
																					margin: const EdgeInsets.only( bottom: 17, left: 42),
																					width: 310,
																					child: Text(
																						"Votre commande a bien été prise en compte",
																						style: TextStyle(
																							color: Color(0xFF181725),
																							fontSize: 28,
																						),
																						textAlign: TextAlign.center,
																					),
																				),
																				Container(
																					margin: const EdgeInsets.only( bottom: 144, left: 84, right: 84),
																					width: double.infinity,
																					child: Text(
																						"Un email de confirmation vient de vous être envoyé.",
																						style: TextStyle(
																							color: Color(0xFF000000),
																							fontSize: 16,
																						),
																						textAlign: TextAlign.center,
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
																							padding: const EdgeInsets.symmetric(vertical: 20),
																							margin: const EdgeInsets.only( bottom: 15, left: 24, right: 24),
																							width: double.infinity,
																							child: Column(
																								children: [
																									Text(
																										"Suivre ma commande",
																										style: TextStyle(
																											color: Color(0xFFFFFFFF),
																											fontSize: 14,
																											fontWeight: FontWeight.bold,
																										),
																									),
																								]
																							),
																						),
																					),
																				),
																				InkWell(
																					onTap: () { print('Pressed'); },
																					child: IntrinsicHeight(
																						child: Container(
																							decoration: BoxDecoration(
																								border: Border.all(
																									color: Color(0xFF006650),
																									width: 1,
																								),
																								borderRadius: BorderRadius.circular(100),
																							),
																							padding: const EdgeInsets.symmetric(vertical: 20),
																							margin: const EdgeInsets.symmetric(horizontal: 24),
																							width: double.infinity,
																							child: Column(
																								children: [
																									Text(
																										"Revenir sur l’accueil",
																										style: TextStyle(
																											color: Color(0xFF006650),
																											fontSize: 14,
																											fontWeight: FontWeight.bold,
																										),
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