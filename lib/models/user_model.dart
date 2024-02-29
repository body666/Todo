class userModel{
  String username;
  String email;
  String id;

  userModel({
    required this.username,
    required this.email,
    required this.id
  });

  userModel.fromJson(Map<String, dynamic>json) :this(
    id: json["id"],
    email: json["email"],
    username: json["username"],
  );
  Map<String,dynamic>toJson(){
    return {
      "id": id,
      "email": email,
     "username": username
    };
  }

}