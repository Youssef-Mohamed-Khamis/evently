class UserModel{
  String id;
  String name;
  String email;
  UserModel({required this.id,required this.name,required this.email});

  UserModel.fromFireStore(Map<String,dynamic>? data)
    : this (
    id: data!['id'] as String,
    name: data!['name'] as String,
    email: data!['email'] as String,
  );


  Map<String,dynamic> toFireStore(){
    return{
      'id':id,
      'email':email,
      'name':name,
    };
  }
}