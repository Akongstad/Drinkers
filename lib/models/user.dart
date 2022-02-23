class UserEntity{
  final String uid;

  UserEntity({required this.uid});
}

class UserData{

  final String? uid;
  final String? name;
  final String? drink;
  final int? strength;

  UserData({this.uid, this.strength, this.name, this.drink});
}