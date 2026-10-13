import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/core/models/event_model.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/layout/screens/home_screen/home_screen.dart';
import 'package:evently/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_category.dart';
import '../../../core/models/event_provider/event_provider.dart';
import '../../layout/screens/home_screen/widgets/tab_widget.dart';

class AddEventScreen extends StatelessWidget {
  AddEventScreen({super.key});
  AddEventScreen.edit({super.key,required this.event});

  EventModel? event;
  static const String routeName="addEvent";

  String _categoryName(AppLocalizations l, AppCategory c) {
    switch (c.id) {
      case "sport": return l.catSport;
      case "meeting": return l.catMeeting;
      case "exhibition": return l.catExhibition;
      case "birthday": return l.catBirthday;
      default: return c.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    var provider=Provider.of<AppProvider>(context);
    final l = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (context){
        final p = EventProvider();
        if (event != null) {
          p.fillFromEvent(event!);
        }
        return p;
      },
      child: Scaffold(
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
          title: Text(event!=null ? l.editEvent : l.addEvent,style: theme.textTheme.titleLarge,),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Consumer<EventProvider>(
                builder: (BuildContext context, eventProvider, Widget? child) {
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(eventProvider.selectedCategory.image)),
                      SizedBox(height: 16,),
                      DefaultTabController(
                        length: AppCategory.categories.length,
                        initialIndex: eventProvider.currentIndex,
                        child: TabBar(
                          onTap: (value){
                            eventProvider.changeIndex(value);
                          },
                          dividerColor: Colors.transparent,
                          indicatorColor: Colors.transparent,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          padding: EdgeInsets.all(0),
                          labelPadding: EdgeInsets.all(8),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            ...AppCategory.categories.map((e){
                              int categoryIndex=AppCategory.categories.indexOf(e);
                              return TabWidget(
                                isSelected: eventProvider.currentIndex==categoryIndex,
                                category: AppCategory(
                                  image: e.image,
                                  name: _categoryName(l, e),
                                  id: e.id,
                                  iconData: e.iconData,
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(l.title,style:TextStyle(
                          color:provider.themeMode==ThemeMode.dark? AppColors.darkTextColor:AppColors.lightTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                      SizedBox(height: 8,),
                      TextFormField(
                        controller: eventProvider.titleController,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color:provider.themeMode==ThemeMode.dark? AppColors.darkTextColor:AppColors.lightTextColor,
                        ),
                        decoration: InputDecoration(
                          hintText: l.eventTitleHint,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text(l.description,style: TextStyle(
                          color:provider.themeMode==ThemeMode.dark? AppColors.darkTextColor:AppColors.lightTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 140,
                        child: TextFormField(
                          controller: eventProvider.descController,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:provider.themeMode==ThemeMode.dark? AppColors.darkTextColor:AppColors.lightTextColor,
                          ),
                          expands: true,
                          maxLines: null,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            hintText: l.eventDescriptionHint,
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          Icon(Icons.date_range,color: theme.primaryColor,),
                          SizedBox(width: 8,),
                          Text(l.eventDate,style: TextStyle(
                              color:provider.themeMode==ThemeMode.dark? AppColors.darkTextColor:AppColors.lightTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              final now = DateTime.now();
                              final selected = eventProvider.selectedDateTime;
                              showDatePicker(context: context,
                                  firstDate: (selected != null && selected.isBefore(now)) ? selected : now,
                                  initialDate: selected ?? now,
                                  lastDate: (selected != null && selected.isAfter(now.add(Duration(days: 365)))) ? selected :DateTime.now().add(Duration(days: 365))).then((value){
                                if(value!=null){
                                  eventProvider.changeDate(value);
                                }

                              });
                            },
                            child: Text(eventProvider.selectedDateTime==null?l.chooseDate:DateFormat.yMd(provider.locale).format(eventProvider.selectedDateTime!),style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),),
                          )
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          Icon(Icons.timer,color: theme.primaryColor,),
                          SizedBox(width: 8,),
                          Text(l.eventTime,style: TextStyle(
                              color:provider.themeMode==ThemeMode.dark? AppColors.darkTextColor:AppColors.lightTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              showTimePicker(
                                  context: context,
                                  initialTime: eventProvider.selectedTime ?? TimeOfDay.now()).then((value){
                                if(value!=null){
                                  eventProvider.changeTime(value);
                                }
                              });
                            },
                            child:Text(eventProvider.selectedTime==null?l.chooseTime:eventProvider.selectedTime!.format(context),style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),),
                          )
                        ],
                      ),
                      SizedBox(height: 24,),
                      ElevatedButton(onPressed: (){
                        if(event!=null){
                          eventProvider.updateEvent(context, event! );
                        }
                        else{
                          eventProvider.addEvent(context);
                        }

                      }, child: Center(child: eventProvider.isLoading?
                      SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator()):Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(event!=null?l.updateEvent:l.addEvent,style: theme.textTheme.titleLarge!.copyWith(
                            color: Colors.white
                        ),),
                      ),))
                    ],
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}