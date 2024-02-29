class TaskModel{
  String id;
  String title;
  String description;
  bool isDone;
  int date;
  String userId;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    this.id="",
    this.isDone=false,
    required this.userId
  });

  TaskModel.fromJson(Map<String,dynamic>data)
  //data:the name of map
  :this(
    id: data ["id"],
    date: data ["date"],
    description: data ["description"],
    title: data ["title"],
    isDone:data ["isDone"],
    userId: data["userId"]
  );

  Map<String,dynamic>toJson(){
    return {
      "id":id,
      "title":title,
      "description":description,
      "date":date,
      "isDone":isDone,
     "userId" :userId
    };
  }


}