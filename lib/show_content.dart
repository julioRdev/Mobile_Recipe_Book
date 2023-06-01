import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowContent extends StatefulWidget {
  String recipeKey;
  ShowContent({required this.recipeKey});

  @override
  State<ShowContent> createState() => _ShowContentState();
}

class _ShowContentState extends State<ShowContent> {
  //CONTROLADORES
  TextEditingController recipeName = TextEditingController();
  TextEditingController recipeType = TextEditingController();
  TextEditingController recipeIngredients = TextEditingController();
  TextEditingController recipeSteps = TextEditingController();
  TextEditingController recipeTime = TextEditingController();

  //VARIABLES PARA LA IMAGEN
  File? file;
  var url;

  DatabaseReference? dbRef;//INSTANCIA DE UN OBJETO DBR

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('recipes');
    recipeData();
  }

  void recipeData() async {
    DataSnapshot snapshot = await dbRef!.child(widget.recipeKey).get();//VALORES ALMACENADOS EN SNAPSHOT POR MEDIO DE LA KEY

    Map recipe = snapshot.value as Map;

    setState(() {//LOS CONTROLADORES ALMACENAN LA INFORMACION DE LA RECETA
      recipeName.text = recipe['name'];
      recipeType.text = recipe['type'];
      recipeIngredients.text = recipe['ingredients'];
      recipeSteps.text = recipe['steps'];
      recipeTime.text = recipe['time'];
      url = recipe['url'];
    });
  }

  //SE MUESTRA_TODO EL CONTENIDO DE LA RECETA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            recipeName.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25,
                fontFamily: 'Cocogoose'
            )
        ),
        backgroundColor: const Color(0xFF5D463B),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 360,
              alignment: Alignment.center,
              color: Colors.grey,
              child: url == null//VERIFICACION SI SE INSERTO UNA IMAGEN O NO
                  ? const Center(
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 70,
                    )
                  )
                  : GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: Image(
                                image: NetworkImage(url),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  const SizedBox(
                    width: 130,
                  ),
                  const Center(
                    child: Icon(
                      Icons.access_time_outlined
                    ),
                  ),
                  Center(
                    child: Text(
                      recipeTime.text,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                    recipeType.text,
                  textAlign: TextAlign.center,
                )
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 1,
              width: 340,
              child: Container(
                color: Colors.black45,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: const Text(
                'Ingredientes',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cocogoose'
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text(
                  recipeIngredients.text,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 1,
              width: 340,
              child: Container(
                color: Colors.black45,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: const Text(
                'Procedimiento',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cocogoose'
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text(
                  recipeSteps.text,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 1,
              width: 340,
              child: Container(
                color: Colors.black45,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}