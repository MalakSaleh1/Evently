import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/modules/add_event/screens/add_event_screen.dart';
import 'package:evently/modules/layout/screens/favorite_screen/favorite_screen.dart';
import 'package:evently/modules/layout/screens/home_screen/home_screen.dart';
import 'package:evently/modules/layout/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatefulWidget {
  static const String routeName="layout";
   LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List screens=[HomeScreen(),FavoriteScreen(),ProfileScreen()];
  int selectedIcon=0;

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var provider=Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AddEventScreen.routeName);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: theme.primaryColor ,
        child: Icon(Icons.add,color: Colors.white,),

      ),
      body: screens[selectedIcon],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(48),topLeft: Radius.circular(48)),
        child: BottomNavigationBar(
          currentIndex: selectedIcon,
          onTap: (index){
            selectedIcon=index;
            setState(() {

            });
          },
            items: [
          BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              activeIcon: Icon(Iconsax.home_25),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.heart),
              activeIcon: Icon(Iconsax.heart5),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              label: "Profile"),
        ]),
      ),
    );
  }
}
