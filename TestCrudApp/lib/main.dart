import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/All_Students.dart';

void  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController  nom_controller =  TextEditingController();
  TextEditingController prenom_controller =  TextEditingController();
  TextEditingController ville_controller =  TextEditingController();
  final docstudent =  FirebaseFirestore.instance;
  var i = 1;
  create() async {
    try{
      await docstudent.collection("Students").doc("Etu=>"+i.toString()).set({
        'nom': nom_controller.text,
        'prenom': prenom_controller.text,
        'ville':ville_controller.text,
      }
      );
      i++;
    }catch(e){
      print(e);
    }
  }
  update() async {
    try{
      await docstudent.collection("Students").doc(nom_controller.text).update({
        'prenom': prenom_controller.text,
        'ville':ville_controller.text,
      });
    }catch(e){
      print(e);
    }
  }
  delete() async {
    try{
      await docstudent.collection("Students").doc(nom_controller.text).delete();
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: TextFormField(
              controller: nom_controller,
              decoration: const InputDecoration(
                  labelText: "Nom",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0
                    ),
                  )
              ),
              onChanged: (String name){
                // getName(name);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: TextFormField(
              controller: prenom_controller,
              decoration: const InputDecoration(
                  labelText: "Prenom",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0
                    ),
                  )
              ),
              onChanged: (String pren){
                // getPren(pren);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: TextFormField(
              controller: ville_controller,
              decoration: const InputDecoration(
                  labelText: "Ville",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0
                    ),
                  )
              ),
              onChanged: (String ville){
                // getVille(ville);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: (){
                  create();
                  nom_controller.clear();
                  prenom_controller.clear();
                  ville_controller.clear();
                  },
                label: const Text(
                  "Create",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                onPressed: (){
                  update();
                  nom_controller.clear();
                  prenom_controller.clear();
                  ville_controller.clear();
                },
                label: const Text(
                  "Update",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.delete),
                onPressed: (){
                  delete();
                  nom_controller.clear();
                  prenom_controller.clear();
                  ville_controller.clear();
                },
                label: const Text(
                  "delete",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.source),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Second_screen()));
                },
                label: const Text(
                  "Data",
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ],

      ),
    );


  }
}
