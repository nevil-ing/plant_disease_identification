import 'package:flutter/material.dart';

import '../models/card_data.dart';
import '../routes/app_routes.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback? onPressed;
    AppRoutes? route; 
    CustomCard({
    Key? key,
    required this.imagePath,
     required this.title,
    required this.subtitle,
     this.route, 
    this.onPressed, required this.cardData,
  }) : super(key: key);

 AppRoutes getRouteFromCardData(CardData cardData) {
   // Implement your logic here to determine the AppRoutes enum based on cardData properties
   switch (cardData.title) {
     case 'Maize Leaf': 
       return AppRoutes.maizeDisease;
     // Add more cases for other card titles as needed
     default:
       return AppRoutes.defaultRoute; // Or throw an error
   }
}
 CardData cardData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
   onTap: onPressed != null 
       ? () => Navigator.of(context).pushNamedAndRemoveUntil(
             '/${getRouteFromCardData(cardData).name}',  // Pass the cardData object
             ModalRoute.withName('/')) 
       : null,

      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20)
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          ListTile(
            title: Text(title,
            style: const TextStyle(
              color: Colors.white,
            ),),
            subtitle: Text(subtitle,
            style: const TextStyle(color: Colors.grey),),
          )
        ],),
      ),
    );
  }
}