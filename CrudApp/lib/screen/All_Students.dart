import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testcrudapp/main.dart';

class Second_screen extends StatelessWidget {

  CollectionReference recipes = FirebaseFirestore.instance.collection('Students');


  delete(id) async {
    try{
      recipes.doc(id).delete();
      print("data delete done");
    }catch(e){
      print(e);
    }
  }

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
                  title: Text(snapshot.data?.docs[index]['nom']+'  '+snapshot.data?.docs[index]['prenom'],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    leading: const Icon(Icons.person,size: 50,color: Colors.blueGrey,),
                  subtitle: Text(snapshot.data?.docs[index]['ville'],style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold)) ,
                  trailing: PopupMenuButton (
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem (
                          onTap: () async {
                            await delete(snapshot.data?.docs[index].id);
                          },
                          child: const Text('Delete'),
                        ),
                        PopupMenuItem(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => MyApp()));
                          },
                          child: const Text('Update'),
                        ),
                      ];
                    },
                  )
                );
              },
            );
          }),
    );
  }
}
