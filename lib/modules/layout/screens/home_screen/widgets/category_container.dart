import 'package:evently/core/constants/app_category.dart';
import 'package:evently/core/models/event_model.dart';
import 'package:flutter/material.dart';
import '../../../../event_details/screens/event_details.dart';

class CategoryContainer extends StatelessWidget {
   CategoryContainer({super.key,required this.event});
  EventModel event;


  @override
  Widget build(BuildContext context) {
    var category=AppCategory.categories.firstWhere((element){
      return element.id==event.categoryId;
    });
    ThemeData theme =Theme.of(context);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetails(event: event)));
      },
      child: Container(
        height: 193,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(category.image),fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.scaffoldBackgroundColor,
                ),
                child: Text(event.date.substring(0, 10),style: theme.textTheme.titleMedium,),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.scaffoldBackgroundColor,
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(event.title,style: theme.textTheme.titleMedium,)),
                    Icon(Icons.favorite_border,color: theme.primaryColor,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
