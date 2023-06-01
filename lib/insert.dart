import 'dart:core';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libro_cocina/profile.dart';
import 'package:quickalert/quickalert.dart';


class CreateR extends StatefulWidget {
  const CreateR({super.key});

  @override
  State<CreateR> createState() => CreateState();
}

class CreateState extends State<CreateR> {
  //CONTROLADORES
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController steps = TextEditingController();
  TextEditingController time = TextEditingController();

  //VARIABLES PARA LA IMAGEN
  File? file;
  ImagePicker image = ImagePicker();
  var url;
  final formKey = GlobalKey<FormState>();
  int contTitle=0;
  int contIngredients=0;
  int contSteps=0;

  DatabaseReference? dbRef;//REFERENCIA A DBR
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('recipes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir nueva receta',
          textAlign: TextAlign.left,
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
            const SizedBox(
              height: 20,
            ),
            Center(//CONTENEDOR PARA EL TITULO
              child: Container(
                width: 345,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [//SOMBREADO DEL CONTENEDOR
                    BoxShadow(
                      color: Colors.black45,
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
                    const SizedBox(
                      height: 6,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(305, 50)),
                      child: TextFormField(
                          controller: name,
                          textAlign: TextAlign.center,
                          validator: (value){
                            if(value!.isEmpty)
                              {
                               return "Favor de rellenar este campo";
                              }
                            else
                              {
                                contTitle=1;
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
            const SizedBox(
              height: 20,
            ),
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
                            color: Colors.black45,
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
                      controller: type,
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
            const SizedBox(
              height: 15,
            ),
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
                          color: Colors.black45,
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
                    controller: time,
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
            const SizedBox(
              height: 50,
            ),
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
            const SizedBox(
              height: 10,
            ),
            Center(//CONTENEDOR PARA LOS INGREDIENTES
              child: Container(
                width: 345,
                height: 140,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
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
                  controller: ingredients,
                  validator: (value2){
                    if(value2!.isEmpty)
                    {
                      return "Favor de rellenar este campo";
                    }
                    else
                    {
                      contIngredients=1;
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
            const SizedBox(
              height: 50,
            ),
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
            const SizedBox(
              height: 10,
            ),
            Center(//CONTENEDOR PARA EL PROCEDIMIENTO
              child: Container(
                width: 345,
                height: 140,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
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
                  controller: steps,
                  validator: (value3){
                    if(value3!.isEmpty)
                    {
                      return "Favor de rellenar este campo";
                    }
                    else
                    {
                      contSteps=1;
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
            const SizedBox(
              height: 60,
            ),
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
            const SizedBox(
              height: 10,
            ),
            Center(//CONTENEDOR PARA INSERTAR UNA IMAGEN
              child: SizedBox(
                  height: 100,
                  width: 200,
                  child: file == null
                      ? IconButton(
                           icon: const Icon(
                          Icons.add_a_photo_sharp,
                          size: 90,
                          color: Colors.black54,
                      ),
                        onPressed: () {
                         getImage();
                       },
                    )
                      : MaterialButton(
                        height: 100,
                          child: Image.file(
                             file!,
                             fit: BoxFit.fill,
                         ),
                         onPressed: () {
                              getImage();
                           },
                     )
              ),
            ),
            const SizedBox(
              height: 75,
            ),
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
                    _validarCampos(context,contTitle,contIngredients,contSteps);
                  }
              },
              color: const Color(0xFF5D463B),
              child: const Text(
                "Añadir",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                    fontFamily: 'Cocogoose'
                ),
              ),
            ),
              const SizedBox(
                height: 20,
              ),
          ],
        ),
        ),
      ),
    );
  }

  void _validarCampos(BuildContext context, int contTitle, int contIngredients, int contSteps)
  {
    if(contTitle==0 && contIngredients==0 && contSteps==0)
      {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                color: Colors.red,
                height: 50,
                child: Column(
                  children:const [
                    SizedBox(height: 14),
                    Text(
                      "ADVERTENCIA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white
                      ),
                   ),
                  ]
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                children: const [
                  Text("-----------------------------"),
                  SizedBox(height: 10),
                  Text("Favor de completar los siguientes campos: "),
                  SizedBox(height: 15),
                  Text("* Título de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                  Text("* Ingredientes de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                  Text("* Procedimiento de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text("OK"),
                )
              ],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
              )
            )
        );
      }
    else if(contTitle==0 && contIngredients==0 && contSteps==1)
      {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                color: Colors.red,
                height: 50,
                child: Column(
                    children: const [
                      SizedBox(height: 14),
                      Text(
                        "ADVERTENCIA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ]
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text("-----------------------------"),
                    SizedBox(height: 10),
                    Text("Favor de completar los siguientes campos: "),
                    SizedBox(height: 15),
                    Text("* Título de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                    Text("* Ingredientes de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text("OK"),
                )
              ],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
              )
            )
        );
      }
    else if(contTitle==0 && contIngredients==1 && contSteps==0)
      {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                color: Colors.red,
                height: 50,
                child: Column(
                    children:const [
                      SizedBox(height: 14),
                      Text(
                        "ADVERTENCIA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ]
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text("-----------------------------"),
                    SizedBox(height: 10),
                    Text("Favor de completar los siguientes campos: "),
                    SizedBox(height: 15),
                    Text("* Título de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                    Text("* Procedimiento de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text("OK"),
                )
              ],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
              )
            )
        );
      }
    else if(contTitle==0 && contIngredients==1 && contSteps==1)
      {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                color: Colors.red,
                height: 50,
                child: Column(
                    children: const [
                      SizedBox(height: 14),
                      Text(
                        "ADVERTENCIA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ]
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text("-----------------------------"),
                    SizedBox(height: 10),
                    Text("Favor de completar los siguientes campos: "),
                    SizedBox(height: 15),
                    Text("* Título de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text("OK"),
                )
              ],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
             )
            )
        );
      }
    else if(contTitle==1 && contIngredients==0 && contSteps==0)
      {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                color: Colors.red,
                height: 50,
                child: Column(
                    children: const [
                      SizedBox(height: 14),
                      Text(
                        "ADVERTENCIA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ]
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text("-----------------------------"),
                    SizedBox(height: 10),
                    Text("Favor de completar los siguientes campos: "),
                    SizedBox(height: 15),
                    Text("* Ingredientes de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                    Text("* Procedimiento de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text("OK"),
                )
              ],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
              )
            )
        );
      }
    else if(contTitle==1 && contIngredients==0 && contSteps==1)
      {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                color: Colors.red,
                height: 50,
                child: Column(
                    children:const [
                      SizedBox(height: 14),
                      Text(
                        "ADVERTENCIA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ]
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text("-----------------------------"),
                    SizedBox(height: 10),
                    Text("Favor de completar los siguientes campos: "),
                    SizedBox(height: 15),
                    Text("* Ingredientes de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text("OK"),
                )
              ],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0))
             )
            )
        );
      }
    else if(contTitle==1 && contIngredients==1 && contSteps==0)
      {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Container(
                color: Colors.red,
                height: 50,
                child: Column(
                    children: const [
                      SizedBox(height: 14),
                      Text(
                        "ADVERTENCIA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ]
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text("-----------------------------"),
                    SizedBox(height: 10),
                    Text("Favor de completar los siguientes campos: "),
                    SizedBox(height: 15),
                    Text("* Procedimiento de la receta",textAlign: TextAlign.left,style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text("OK"),
                )
              ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))
            )
           )
        );
      }
  }

  getImage() async {//ESCOGER UNA IMAGEN DE LA GALERIA DEL CELULAR
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });

  }

  uploadFile() async {//INSERTAR RECETA SIN IMAGEN
    try {

        Map<String, String> recipe = {//ASIGNAR LA INFORMACION DE LOS CONTROLADORES AL MAP
          'name': name.text,
          'type': type.text,
          'ingredients': ingredients.text,
          'steps': steps.text,
          'time': time.text
        };

        dbRef!.push().set(recipe).whenComplete(() {//UNA VEZ INSERTADA A LA BASE DE DATOS REGRESAR AL MENU PRINCIPAL
              QuickAlert.show(
              context: context,
              title: "Éxito",
              text: "La receta se ha añadido",
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

  uploadFileIm() async {//INSERTAR RECETA CON IMAGEN
    try {

      var imagefile = FirebaseStorage.instance
          .ref()
          .child("recipe_photo")
          .child("/${name.text}.jpg");//ASIGNAMOS EL NOMBRE Y LA LOCACION DE LA IMAGEN
      UploadTask task = imagefile.putFile(file!);//ALMACENAR IMAGEN EN FIREBASE
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      setState(() {
        url = url;
      });
      if (url != null) {//VALIDACION Y ASIGNACION DE LA INFORMACION DE LOS CONTROLADORES AL MAP
        Map<String, String> recipe = {
          'name': name.text,
          'type': type.text,
          'ingredients': ingredients.text,
          'steps': steps.text,
          'time': time.text,
          'url': url
        };

        dbRef!.push().set(recipe).whenComplete(() {//UNA VEZ INSERTADA A LA BASE DE DATOS REGRESAR AL MENU PRINCIPAL
          QuickAlert.show(
            context: context,
            title: "Éxito",
            text: "La receta se ha añadido",
            type: QuickAlertType.success,
            autoCloseDuration: const Duration(seconds: 2),
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
}



