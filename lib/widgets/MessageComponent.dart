// ignore_for_file: must_be_immutable

import 'package:chatapp/BD/auth.dart';
import 'package:chatapp/Modeles/Message.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class MessageComponent extends StatelessWidget {
  Message msg;
  MessageComponent({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: msg.senderId == AuthService().user.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (width * 2) / 2.8,
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: msg.senderId == AuthService().user.uid
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(0),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(20),
                  ),
            gradient: msg.senderId == AuthService().user.uid
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 106, 1, 124).withOpacity(0.7),
                      const Color.fromARGB(255, 241, 3, 83).withOpacity(0.7),
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 241, 3, 83).withOpacity(0.7),
                      const Color.fromARGB(255, 245, 180, 0).withOpacity(0.7),
                    ],
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                msg.content,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    msg.time.toDate().hour < 10 && msg.time.toDate().minute < 10
                        ? "0${msg.time.toDate().hour} : 0${msg.time.toDate().minute}"
                        : msg.time.toDate().hour < 10 &&
                                msg.time.toDate().minute >= 10
                            ? "0${msg.time.toDate().hour} : ${msg.time.toDate().minute}"
                            : msg.time.toDate().hour >= 10 &&
                                    msg.time.toDate().minute < 10
                                ? "${msg.time.toDate().hour} : 0${msg.time.toDate().minute}"
                                : "${msg.time.toDate().hour} : ${msg.time.toDate().minute}",
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  msg.senderId == AuthService().user.uid
                      ? !msg.isDelivered
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            )
                          : Icon(
                              Icons.done_all,
                              color:
                                  msg.isRead ? Colors.blue[900] : Colors.white,
                            )
                      : const Text('')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
