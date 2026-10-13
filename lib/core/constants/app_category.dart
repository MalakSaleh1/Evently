import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppCategory {
  String name;
  String image;
  IconData iconData;
  String id;

  AppCategory({
    required this.image,
    required this.name,
    required this.id,
    required this.iconData
});


  static List<AppCategory>  categories=[
    AppCategory(image: "assets/category/Sport.png", name: "Sport", id: "sport", iconData:Icons.sports_score),
    AppCategory(image: "assets/category/Meeting.png", name: "Meeting", id: "meeting", iconData:Icons.work),
    AppCategory(image: "assets/category/Exhibition.png", name: "Exhibition", id: "exhibition", iconData:Icons.draw),
    AppCategory(image: "assets/category/Birthday.png", name: "Birthday", id: "birthday", iconData:Iconsax.cake),

  ];
}