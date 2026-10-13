import 'package:evently/core/models/event_model.dart';
import 'package:evently/core/models/event_provider/event_provider.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/add_event/screens/add_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_provider/app_provider.dart';
import '../../../core/constants/app_category.dart';

class EventDetails extends StatelessWidget {
  EventDetails({super.key,required this.event});
  EventModel event;
  static String routeName="eventDetails";

  @override
  Widget build(BuildContext context) {
    var user =FirebaseAuth.instance.currentUser;
    var theme =Theme.of(context);
    var provider=Provider.of<AppProvider>(context);
    final l = AppLocalizations.of(context)!;
    var category=AppCategory.categories.firstWhere((element){
      return element.id==event.categoryId;
    });
    return  ChangeNotifierProvider(
      create: (BuildContext context) =>EventProvider(),
      child: Consumer<EventProvider>(
        builder: (BuildContext context, EventProvider eventProvider, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    SizedBox(width: 8,),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.primaryColorLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 6,),
                          Icon(Icons.arrow_back_ios,color: theme.primaryColor,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: theme.scaffoldBackgroundColor,
              title: Text(l.eventDetails,style: theme.textTheme.titleLarge,),
              centerTitle: true,
              actions: [
                user!.uid==event.userId ?Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEventScreen.edit(event: event)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: theme.primaryColorLight
                        ),
                        child: Icon(Icons.edit,color: theme.primaryColor,),
                      ),
                    ),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap: (){
                        eventProvider.deleteEvent(context, event);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: theme.primaryColorLight
                        ),
                        child: Icon(Icons.delete,color: Colors.red),
                      ),
                    ),
                    SizedBox(width: 16,),
                  ],
                ):SizedBox(),
              ],

            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(category.image)),
                  SizedBox(height: 16,),
                  Text(event.title,style: theme.textTheme.titleLarge,),
                  SizedBox(height: 16,),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: theme.primaryColorLight
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.timer,color: theme.primaryColor,),
                        ),
                        SizedBox(width: 16,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.date.substring(0,10),style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: provider.themeMode==ThemeMode.dark?theme.primaryColorDark:Colors.black,
                            ),),
                            Text(event.time,style: theme.textTheme.bodySmall,)
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(l.description,style: theme.textTheme.titleLarge,),
                  SizedBox(height: 16,),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: theme.primaryColorLight
                    ),
                    child: Text(event.desc,style:theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: provider.themeMode==ThemeMode.dark?theme.primaryColorDark:Colors.black,
                        fontSize: 14
                    ) ,),
                  )
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}