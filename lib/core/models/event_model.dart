

class EventModel {
  String id;
  String userId;
  String title;
  String desc;
  String date;
  String time;
  String categoryId;


  EventModel({required this.title,required this.id,required this.date,required this.desc,required this.userId,required this.time,required this.categoryId});



  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "categoryId":categoryId,
      "title":title,
      "description":desc,
      "time":time,
      "date":date,
      "userId":userId,

    };
  }

  factory EventModel.fromJson(Map<String,dynamic> json){
     return EventModel(title: json["title"], id: json["id"], date: json["date"],userId: json["userId"] ,desc: json["description"], time: json["time"], categoryId: json["categoryId"]);
  }



}