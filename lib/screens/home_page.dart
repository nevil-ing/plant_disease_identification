import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plant_app/models/card_data.dart';
import 'package:plant_app/widgets/customPlantCard.dart';
import 'package:plant_app/widgets/custom_drawer.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<CardData> plantList = [
    CardData(
      imagePath: 'assets/images/download.jpg', 
      title: 'Maize Leaf',
      subtitle: '',
      route: '/maizeDetect'),
    CardData(
     imagePath: 'assets/images/download.jpg',
     title: '', 
     subtitle: '',
     route: ''),
    /*CardData(
    imagePath: '', 
    title: '', 
    subtitle: '',
    route: ''),
    CardData(
    imagePath: '', 
    title: '', 
    subtitle: '',
    route: ''),*/
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text('Plant Disease Identification'),
        centerTitle: true,
        elevation: 1,
      ),
      drawer: const CustomDrawer(),
      body: GridView.builder(
         
        physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
        scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2 ,       
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,),
      itemCount: plantList.length,
       itemBuilder: (BuildContext context, int index){
        return CustomCard(
        imagePath: plantList[index].imagePath,
         title: plantList[index].title, 
         subtitle: plantList[index].subtitle,
       // route: getRouteFromCardData(cardData),
      cardData: plantList.first,
         onPressed: (){},
         );
       }),
    );
  }
}

