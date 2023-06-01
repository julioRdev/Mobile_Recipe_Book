import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libro_cocina/profile.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UpdateRecord extends StatefulWidget {
  String recipeKey;
  UpdateRecord({super.key, required this.recipeKey});

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  //CONTROLADORES
  TextEditingController recipeName = TextEditingController();
  TextEditingController recipeType = TextEditingController();
  TextEditingController recipeIngredients = TextEditingController();
  TextEditingController recipeSteps = TextEditingController();
  TextEditingController recipeTime = TextEditingController();

  //VARIABLES DE IMAGEN
  var url;
  var url1;
  File? file;
  ImagePicker image = ImagePicker();

  final formKey = GlobalKey<FormState>();

  DatabaseReference? dbRef;//REFERENCIA

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('recipes');
    recipeData();
  }

  void recipeData() async {
    DataSnapshot snapshot = await dbRef!.child(widget.recipeKey).get();

    Map recipe = snapshot.value as Map;

//LOS CONTROLADORES ALMACENAN LA INFORMACION DE LA RECETA
    setState(() {
      recipeName.text = recipe['name'];
      recipeType.text = recipe['type'];
      recipeIngredients.text = recipe['ingredients'];
      recipeSteps.text = recipe['steps'];
      recipeTime.text = recipe['time'];
      url = recipe['url'];
    });
  }

  //PANTALLA DE ACTUALIZACION
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Actualizar Receta',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 27,
              fontFamily: 'Cocogoose'
          ),
        ),
        backgroundColor: const Color(0xFF5D463B),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(//CONTENEDOR PARA EL TITULO
                child: Container(
                  width: 345,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [//SOMBREADO DEL CONTENEDOR
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 6.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ]
                  ),
                  child: Column(
                      children: [
                        const SizedBox(height: 6),
                        ConstrainedBox(
                          constraints: BoxConstraints.tight(const Size(305, 50)),
                          child: TextFormField(
                            controller: recipeName,
                            textAlign: TextAlign.center,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Favor de rellenar este campo";
                              }
                              else
                                {
                                  return null;
                                }
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Título: Ej. Pastel de Zanahoria',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 130,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: const Text(
                        'Tipo',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cocogoose',
                            color: Colors.grey
                        ),
                        textAlign: TextAlign.left
                    ),
                  ),
                  Container(
                    width: 210,
                    height: 40,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 6.0,
                            spreadRadius: 1.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ]
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(180, 30)),
                      child: TextFormField(
                        controller: recipeType,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Ej. Comida, Bebida, Postre, etc.',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                        ),
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.bottom,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 130,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: const Text(
                        'Tiempo de elaboracion',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cocogoose',
                            color: Colors.grey
                        ),
                        textAlign: TextAlign.left
                    ),
                  ),
                  Container(
                    width: 210,
                    height: 40,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 6.0,
                            spreadRadius: 1.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ]
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(160, 30)),
                      child: TextFormField(
                        controller: recipeTime,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Ej. 1h 30 min',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: const Text(
                    'Ingredientes',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cocogoose',
                        color: Colors.grey
                    ),
                    textAlign: TextAlign.left
                ),
              ),
              const SizedBox(height: 10),
              Center(//CONTENEDOR PARA LOS INGREDIENTES
                child: Container(
                  width: 345,
                  height: 140,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 6.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ]
                  ),
                  child: TextFormField(
                    controller: recipeIngredients,
                    validator: (value2){
                      if(value2!.isEmpty)
                      {
                        return "Favor de rellenar este campo";
                      }
                      else
                        {
                          return null;
                        }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Ej. Leche, huevos, harina, etc.',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0)
                    ),
                    minLines: 1,
                    maxLines: 7,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: const Text(
                    'Procedimiento',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cocogoose',
                        color: Colors.grey
                    ),
                    textAlign: TextAlign.left
                ),
              ),
              const SizedBox(height: 10),
              Center(//CONTENEDOR PARA EL PROCEDIMIENTO
                child: Container(
                  width: 345,
                  height: 140,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 6.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ]
                  ),
                  child: TextFormField(
                    controller: recipeSteps,
                    validator: (value3){
                      if(value3!.isEmpty)
                      {
                        return "Favor de rellenar este campo";
                      }
                      else
                        {
                          return null;
                        }
                    },
                    decoration: const InputDecoration(
                        hintText: 'Ej. Licuar los ingredientes...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0)
                    ),
                    minLines: 1,
                    maxLines: 7,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: const Text(
                    'Imagen',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cocogoose',
                        color: Colors.grey
                    ),
                    textAlign: TextAlign.left
                ),
              ),
              const SizedBox(height: 10),
              Center(//CONTENEDOR PARA INSERTAR UNA IMAGEN
                child: SizedBox(
                    height: 100,
                    width: 200,
                  child: url == null
                      ? MaterialButton(
                        height: 100,
                        child: const Icon(
                          Icons.add_a_photo_sharp,
                          size: 50,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      )

                      : MaterialButton(
                        height: 100,
                        child: Image.network(url),
                        onPressed: () {
                          getImage();
                        },
                      ),
                ),
              ),
              const SizedBox(height: 50),
              MaterialButton(
                height: 40,
                shape: const StadiumBorder(),
                onPressed: () {
                  if(formKey.currentState!.validate())
                  {
                    if (file != null) {
                      uploadFileIm();
                    }
                    else
                    {
                      uploadFile();
                    }
                  }
                  else
                  {
                    QuickAlert.show(
                      context: context,
                      title: "Advertencia",
                      text: "Favor de llenar los campos seleccionados",
                      type: QuickAlertType.warning,
                    );
                  }
                },
                color: const Color(0xFF5D463B),
                child: const Text(
                  "Actualizar",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                      fontFamily: 'Cocogoose'
                  ),
                ),
              ),
              const SizedBox(height: 45),
              MaterialButton(//BOTON PARA BORRAR RECETA
                height: 40,
                shape: const StadiumBorder(),
                onPressed: () {
                  delete();
                },
                color: Colors.red,
                child: const Text(
                  "Eliminar",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                      fontFamily: 'Cocogoose'
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  delete()  {//ELIMINAR LA RECETA CON LA KEY
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Expanded(
            child: Container(
              color: Colors.red,
              height: 50,
              child: Column(
                  children: const [
                    SizedBox(height: 14),
                    Text(
                      "Eliminar Receta",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ]
              ),
            )
          ),
          content: const Text("¿Estas seguro de eliminar esta receta?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancelar")
            ),
            ElevatedButton(
                onPressed: () async{
                  try
                  {
                    await deleteConfirm();
                    Navigator.pop(context);
                  }
                  catch(error)
                  {
                    print(error);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                child: const Text("Borrar")
            )
          ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))
          )
        )
    );
  }

  deleteConfirm() async{
    dbRef!.child(widget.recipeKey).remove().whenComplete(() {
      QuickAlert.show(
          context: context,
          title: "Éxito",
          text: "La receta se ha eliminado",
          type: QuickAlertType.success,
          confirmBtnText: 'De acuerdo'
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HProfile(),
        ),
      );
    }
    );
  }

  getImage() async {//OBTENCION DE IMAGEN DE LA GALERIA
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      url = null;
      file = File(img!.path);
    });
  }


  uploadFileIm() async {//INSERTAR RECETA CON IMAGEN
    try {
      var imagefile = FirebaseStorage.instance
          .ref()
          .child("recipe_photo")
          .child("/${recipeName.text}.jpg");//ASIGNAMOS EL NOMBRE Y LA LOCACION DE LA IMAGEN
      UploadTask task = imagefile.putFile(file!);//ALMACENAR IMAGEN EN FIREBASE
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      setState(() {
        url = url;
      });
      if (url != null) {//VALIDACION Y ASIGNACION DE LA INFORMACION DE LOS CONTROLADORES AL MAP
        Map<String, String> recipe = {
          'name': recipeName.text,
          'type': recipeType.text,
          'ingredients': recipeIngredients.text,
          'steps': recipeSteps.text,
          'time': recipeTime.text,
          'url': url
        };

        dbRef!.child(widget.recipeKey).update(recipe).whenComplete(() {//UNA VEZ INSERTADA A LA BASE DE DATOS REGRESAR AL MENU PRINCIPAL
          QuickAlert.show(
            context: context,
            title: "Éxito",
            text: "La receta se ha actualizado",
            type: QuickAlertType.success,
              confirmBtnText: 'De acuerdo'
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HProfile(),
            ),
          );
        }
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }
  uploadFile() async {//INSERTAR RECETA SIN IMAGEN
    try {

      Map<String, String> recipe = {//ASIGNAR LA INFORMACION DE LOS CONTROLADORES AL MAP
        'name': recipeName.text,
        'type': recipeType.text,
        'ingredients': recipeIngredients.text,
        'steps': recipeSteps.text,
        'time': recipeTime.text
      };

      dbRef!.child(widget.recipeKey).update(recipe).whenComplete((){//UNA VEZ INSERTADA A LA BASE DE DATOS REGRESAR AL MENU PRINCIPAL
        QuickAlert.show(
          context: context,
          title: "Éxito",
          text: "La receta se ha actualizado",
          type: QuickAlertType.success,
          confirmBtnText: 'De acuerdo'
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HProfile(),
          ),
        );
      }
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

