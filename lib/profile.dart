import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:libro_cocina/show_content.dart';
import 'insert.dart';
import 'update.dart';

class HProfile extends StatelessWidget {
  const HProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference dbRef =
    FirebaseDatabase.instance.ref().child('recipes');//REFERENCIA AL APARTADO DE RECETAS EN FIREBASE
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5D463B),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateR(),//BOTON PARA INSERTAR RECETA
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Lista de Recetas',
          style: TextStyle(
            fontSize: 30,
              fontFamily: 'Cocogoose'
          ),
        ),
        backgroundColor: const Color(0xFF5D463B),
      ),
      body: FirebaseAnimatedList(
        query: dbRef,
        shrinkWrap: true,//AJUSTE DE SCROLLING
        itemBuilder: (context, snapshot, animation, index) {
          Map recipe = snapshot.value as Map;
          recipe['key'] = snapshot.key;//CLAVE DE ALGUNA RECETA EN ESPECIFICO
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) => ShowContent(//MOSTRAR RECETAS, EL PARAMETRO ES LA CLAVE DE DICHA RECETA
                recipeKey: recipe['key'],
                 ),
                ),
              );
            },
            //CONTENEDOR PARA CADA RECETA, INCLUYE EL GESTURE DETECTOR Y LA OPCION DE EDICION
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Colors.brown[100],
                trailing: IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    size: 25,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (_) => UpdateRecord(//ACTUALIZAR RECETAS, EL PARAMETRO ES LA CLAVE DE DICHA RECETA
                          recipeKey: recipe['key'],
                        ),
                    ),
                    );
                  },
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: recipe['url'] == null
                    ? const Icon(
                    Icons.image
                  )
                      : CircleAvatar(
                    backgroundImage: NetworkImage(
                      recipe['url']
                    ),
                    backgroundColor: Colors.black12,
                  )
                ),
                title: Text(
                  recipe['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cocogoose'
                  ),
                ),
                subtitle: Text(
                  recipe['type'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                      fontFamily: 'Cocogoose'
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}