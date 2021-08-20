import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Ops, something went wrong!');
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text('Hey, user does not exist!');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              'Welcome, ${data['fname']} ${data['lname']}',
            );
          }
          return Text(
            'Loading...',
          );
        });
  }
}
