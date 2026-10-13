import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService{

  var firebase=FirebaseFirestore.instance;

  Future<void> addEvent(EventModel event) async {
    final doc = firebase.collection("Events").doc();
    event.id = doc.id;
    await doc.set(event.toJson());
  }

  Stream<List<EventModel>> getEventsStream() {
    return firebase
        .collection("Events")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) {
        final event = EventModel.fromJson(e.data());
        event.id = e.id;
        return event;
      }).toList();
    });
  }
   Future<void> updateEvent (EventModel event)async{
    await firebase.collection("Events").doc(event.id).update(event.toJson());
  }
  Future<void> deleteEvent (EventModel event)async{
    await firebase.collection("Events").doc(event.id).delete();
  }

}