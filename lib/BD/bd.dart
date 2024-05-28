// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:chatapp/BD/auth.dart';
import 'package:chatapp/Modeles/Message.dart';
import 'package:chatapp/Modeles/Utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBServices {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final msgCollection = FirebaseFirestore.instance.collection("Messages");

  Stream<List<Utilisateur>> getDiscussionUser(List<String>? userListId) {
    StreamController<List<Utilisateur>> controller = StreamController();

    if (userListId != null && userListId.isNotEmpty) {
      List<List<String>> dividedIds = divideList(userListId, 10);

      Future.forEach(dividedIds, (subList) async {
        QuerySnapshot snapshot =
            await userCollection.where('uid', whereIn: subList).get();

        List<Utilisateur> users = snapshot.docs
            .map((doc) =>
                Utilisateur.forJson(doc.data() as Map<String, dynamic>))
            .toList();

        controller.add(users);
      }).then((_) {
        controller.close();
      });
    } else {
      controller.addError('userListId est null ou vide');
      controller.close();
    }

    return controller.stream;
  }

  Future<bool> saveUser(Utilisateur user) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Utilisateur?> getUserId(String id) async {
    try {
      final user = await userCollection.doc(id).get();
      return Utilisateur.forJson(user.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Future<bool> sendMessage(Message msg) async {
    try {
      await msgCollection.doc().set(msg.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<Message>> getMessage(String receiverUID,
      [bool myMessage = true]) {
    return msgCollection
        .where('senderId',
            isEqualTo: myMessage ? AuthService().user.uid : receiverUID)
        .where('receiverId',
            isEqualTo: myMessage ? receiverUID : AuthService().user.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Message.fromJson(e.data(), e.id)).toList());
  }

  List<List<String>> divideList(List<String> list, int chunkSize) {
    List<List<String>> dividedList = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      dividedList.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return dividedList;
  }

  Future<Message?> getLastMessage(
      String currentUserId, String otherUserId) async {
    QuerySnapshot sentMessages = await msgCollection
        .where('senderId', isEqualTo: currentUserId)
        .where('receiverId', isEqualTo: otherUserId)
        .orderBy('time', descending: true)
        .limit(1)
        .get();

    QuerySnapshot receivedMessages = await msgCollection
        .where('senderId', isEqualTo: otherUserId)
        .where('receiverId', isEqualTo: currentUserId)
        .orderBy('time', descending: true)
        .limit(1)
        .get();

    List<QueryDocumentSnapshot> allMessages = [
      ...sentMessages.docs,
      ...receivedMessages.docs
    ];
    allMessages.sort(
        (a, b) => (b['time'] as Timestamp).compareTo(a['time'] as Timestamp));

    if (allMessages.isNotEmpty) {
      return Message.fromJson(allMessages.first.data() as Map<String, dynamic>,
          allMessages.first.id);
    } else {
      return null; // Aucun message trouvé
    }
  }

  Future<int> countUnreadMessages(
      String currentUserId, String otherUserId) async {
    QuerySnapshot unreadMessages = await msgCollection
        .where('receiverId', isEqualTo: currentUserId)
        .where('senderId', isEqualTo: otherUserId)
        .where('isRead', isEqualTo: false)
        .get();

    return unreadMessages.size;
  }

  Future<void> markMessagesAsRead(
      String currentUserId, String otherUserId) async {
    QuerySnapshot messagesToUpdate = await msgCollection
        .where('receiverId', isEqualTo: currentUserId)
        .where('senderId', isEqualTo: otherUserId)
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in messagesToUpdate.docs) {
      await doc.reference.update({'isRead': true});
    }
  }

  Future<void> updateDiscussionList(
      List<String> updatedDiscussionList, String id) async {
    try {
      await userCollection.doc(id).update({
        'discussion': updatedDiscussionList,
      });
    } catch (e) {
      print('Erreur lors de la mise à jour de la liste de discussions : $e');
    }
  }
}
