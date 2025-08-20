class User{
  String? id;
  String? name;
  String? email;
  List<String>? favorites;
  User({this.id , this.name , this.email,this.favorites});

  User.fromFirestore(Map<String,dynamic>? data){
    id = data?["id"];
    name = data?["name"];
    email = data?["email"];
    favorites = List<String>.from(data?["favorites"]);
  }
  Map<String,dynamic> toFirestore(){
    return {
      "id": id,
      "name":name,
      "email":email,
      "favorites":favorites
    };
  }
}

/*
* {
*
*   "id":0,
*   "email":"ali@gmail.com"
* }
*
*
* */