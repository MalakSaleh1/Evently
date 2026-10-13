import 'package:evently/core/constants/app_category.dart';
import 'package:evently/core/models/event_model.dart';
import 'package:evently/core/services/db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../modules/layout/screens/home_screen/home_screen.dart';

class EventProvider extends ChangeNotifier{
 final user =FirebaseAuth.instance.currentUser;
  int currentIndex=0;
  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();

 AppCategory selectedCategory=AppCategory.categories.first;
  void changeIndex(value){
    currentIndex=value;
    selectedCategory=AppCategory.categories[currentIndex];
    notifyListeners();
  }

  void changeDate(value){
    selectedDateTime=value;
    notifyListeners();
  }

  void changeTime(value){
    selectedTime=value;
    notifyListeners();
  }

  bool isLoading=false;
  void addEvent(BuildContext context)async{
    if (selectedTime == null || selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Choose date and time")),
      );
      return;
    }
    isLoading=true;
    notifyListeners();
    var service=DbService();
    await service.addEvent(EventModel(title: titleController.text,userId: user!.uid, id:"", date: selectedDateTime.toString(), desc: descController.text, time: selectedTime!.format(context), categoryId: selectedCategory.id));
    isLoading=false;
    notifyListeners();
    Navigator.pop(context);
  }

 void fillFromEvent(EventModel event) {
   titleController.text = event.title;
   descController.text = event.desc;

   final index = AppCategory.categories.indexWhere((c) => c.id == event.categoryId);
   currentIndex = index == -1 ? 0 : index;
   selectedCategory = AppCategory.categories[currentIndex];

   selectedDateTime = DateTime.tryParse(event.date);

   final raw = event.time.trim().toUpperCase();
   final isPm = raw.contains('PM');
   final isAm = raw.contains('AM');
   final parts = raw.replaceAll(RegExp(r'[^0-9:]'), '').split(':');
   if (parts.length == 2) {
     int hour = int.tryParse(parts[0]) ?? 0;
     final minute = int.tryParse(parts[1]) ?? 0;
     if (isPm && hour < 12) hour += 12;
     if (isAm && hour == 12) hour = 0;
     selectedTime = TimeOfDay(hour: hour, minute: minute);
   }
 }


 Future<void> updateEvent(BuildContext context, EventModel old) async {
   isLoading = true;
   notifyListeners();

   final updated = EventModel(
     id: old.id,
     userId: old.userId,
     title: titleController.text,
     desc: descController.text,
     date: selectedDateTime.toString(),
     time: selectedTime!.format(context),
     categoryId: selectedCategory.id,
   );

   await DbService().updateEvent(updated);

   isLoading = false;
   notifyListeners();
   Navigator.popUntil(context, (route) => route.isFirst);
 }

 Future<void> deleteEvent(BuildContext context,EventModel event) async {
   isLoading = true;
   notifyListeners();
   await DbService().deleteEvent(event);
   isLoading = false;
   notifyListeners();
   Navigator.popUntil(context, (route) => route.isFirst);
 }

 void clear() {
   titleController.clear();
   descController.clear();
   selectedDateTime = null;
   selectedTime = null;
   currentIndex = 0;
   selectedCategory = AppCategory.categories.first;
 }




}