import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class Utilisateur {
  late String uid;
  late String userName;
  late String tel;
  String? pp;
  List<String>? discussion;
  late Timestamp? lastConnection;

  static Utilisateur? user;

  static List<Utilisateur> users = [];

  Utilisateur({
    required this.uid,
    required this.userName,
    required this.tel,
    this.pp,
    this.discussion,
    this.lastConnection,
  });

  factory Utilisateur.forJson(Map<String, dynamic> json) {
    return Utilisateur(
      uid: json['uid'],
      userName: json['userName'],
      tel: json['tel'],
      pp: json['pp'],
      discussion: List<String>.from(json['discussion']),
      lastConnection: json['lastConnection'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'tel': tel,
      'pp': pp,
      'discussion': discussion,
      'lastConnection': lastConnection
    };
  }

  factory Utilisateur.forJson2(Map<String, dynamic> json) {
    return Utilisateur(
      uid: json['uid'],
      userName: json['userName'],
      tel: json['tel'],
      pp: json['pp'],
    );
  }

  Map<String, dynamic> toJson2() {
    return {
      'uid': uid,
      'userName': userName,
      'tel': tel,
      'pp': pp,
    };
  }

  static void loadUsersFromLocalStorage() {
    final box = GetStorage();
    List<dynamic>? usersJson = box.read('users');
    if (usersJson == null || usersJson.isEmpty) {
      print('salut. la liste des objets en interne est null');
    } else {
      print('baaaaaaaahhhhhhh. la liste des objets nest plus vide');
      users = usersJson
          .map((json) => Utilisateur.forJson2(Map<String, dynamic>.from(json)))
          .toList();
    }
  }
}
