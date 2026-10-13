import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/core/constants/app_category.dart';
import 'package:evently/modules/event_details/screens/event_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../../core/app_colors.dart';

class TabWidget extends StatelessWidget {
   TabWidget({super.key,required this.isSelected,required this.category});

  bool isSelected;
  AppCategory category;

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AppProvider>(context);
    ThemeData theme=Theme.of(context);
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
        decoration: BoxDecoration(
          color:isSelected?theme.primaryColor:theme.primaryColorLight,
          border: Border.all(
           color:  provider.themeMode==ThemeMode.dark? isSelected?theme.primaryColorLight:theme.primaryColor:theme.primaryColorLight,
          ),
          borderRadius: BorderRadius.circular(16),

          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
            ),
          ],
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Icon(category.iconData,color: isSelected?Colors.white:theme.primaryColor,),
              SizedBox(width: 4,),
              Text(category.name,style: TextStyle(
                color:provider.themeMode==ThemeMode.light? isSelected? Colors.white:AppColors.lightTextColor: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600
              )),
            ]
        ),
      ),
    );
  }
}
