import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Second_screen extends StatelessWidget {

  CollectionReference recipes = FirebaseFirestore.instance.collection('Students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: recipes.snapshots(),
          builder: (context,snapshot){
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView.builder(
              itemCount:snapshot.data?.docs.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(snapshot.data?.docs[index]['nom']+'  '+snapshot.data?.docs[index]['prenom'],style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    leading: const Icon(Icons.person,size: 50,color: Colors.blue,),
                  subtitle: Text(snapshot.data?.docs[index]['ville'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)) ,
                );
              },
            );
          }),
    );
  }
}
