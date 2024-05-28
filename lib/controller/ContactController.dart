// ignore_for_file: depend_on_referenced_packages

import 'package:chatapp/BD/bd.dart';
import 'package:chatapp/Modeles/Utilisateur.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactController {
  Future<List<Utilisateur>> actualualiseContact() async {
    List<Contact>? contacts;
    List<String> listContact = [];
    List<Utilisateur> users = [];
    List<List<String>> sublistContact = [];
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      for (var i = 0; i < contacts.length; i++) {
        if (contacts[i].phones.length > 1) {
          for (var j = 0; j < contacts[i].phones.length; j++) {
            listContact.add(formatPhoneNumber(contacts[i].phones[j].number));
          }
        } else {
          try {
            listContact.add(formatPhoneNumber(contacts[i].phones[0].number));
          } catch (e) {
            i = i + 1;
          }
        }
      }
      for (var i = 0; i < listContact.length; i += 10) {
        sublistContact.add(listContact.sublist(
            i, i + 10 > listContact.length ? listContact.length : i + 10));
      }

      for (var batch in sublistContact) {
        final querySnapshot = await DBServices()
            .userCollection
            .where('tel', whereIn: batch)
            .get();

        querySnapshot.docs.forEach((doc) {
          Utilisateur utilisateur = Utilisateur.forJson(doc.data());
          users.add(utilisateur);
        });
      }

      if (users != []) {
        saveUsersLocally(users);
      }
    }
    return users;
  }

  String formatPhoneNumber(String input) {
    String formattedNumber = input.replaceAll(' ', '');

    if (formattedNumber.length == 8) {
      // Ajouter des zéros à gauche pour atteindre une longueur de 9 caractères
      formattedNumber = formattedNumber.padLeft(9, '6');
    }

    return formattedNumber;
  }

  void saveUsersLocally(List<Utilisateur> users) {
    final box = GetStorage();
    box.write('users', users.map((user) => user.toJson2()).toList());
  }
}
