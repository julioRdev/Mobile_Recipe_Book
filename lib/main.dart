import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:libro_cocina/profile.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //INICIAR CONEXION FIREBASE
  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return const LoginScreen();//UNA VEZ CONECTADA IR A LA PAGINA DEL LOGIN
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //LOGIN
  static Future<User?> loginEmail(
      {required String email,
        required String password,
        required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);//INICIO DE SESION CON CORREO Y CONTRASEÑA
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){//NOTA *MOSTRAR UN WARNING EN LA PANTALLA*
        print("Ningun usuario coincide con el correo electronico");
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {

    //CONTROLADORES
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    //PANTALLA DE INICIO DE SESION
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        //padding: EdgeInsets.fromLTRB(18.0, 110.0, 20.0, 0.0),
        child: Container(
          height: 730,
          width: 360,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('https://previews.123rf.com/images/topform8/topform81307/topform8130700213/20674622-comida-r%C3%A1pida-de-fondo-sin-fisuras.jpg'),
                fit: BoxFit.cover
            )
          ),
          child: Column(
            children: [
              const SizedBox(height: 100,),
              Center(
                child: Container(
                  height: 550,
                  width: 310,
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8)
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Recetario",
                          style: TextStyle(
                            color: Color(0xFF5D463B),
                            fontSize: 55.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mexicana'
                          ),
                        ),
                        const SizedBox(
                          height: 44.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(color: Colors.black)
                          ),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Correo Electronico",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.mail, color: Colors.black,),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 26.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                              border: Border.all(color: Colors.black)
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Contraseña",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock, color: Colors.black,),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const Text(
                          "Olvidaste tu contraseña?",
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 88.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 45),
                            SizedBox(
                              width: 200,
                              child: RawMaterialButton(
                                fillColor: const Color(0xFF5D463B),
                                elevation: 0.0,
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)
                                ),
                                onPressed: () async{
                                  User? user = await loginEmail(//FUNCION ASINCRONA PARA ESPERAR CREDENCIALES
                                      email: emailController.text, password: passwordController.text, context: context);
                                  print(user);
                                  if(user != null){
                                    await QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.loading,
                                        title: 'CARGANDO',
                                        text: ' ',
                                        autoCloseDuration: Duration(seconds: 2)
                                    );
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context)=> HProfile()
                                        )
                                    );//REDIRECCIONAMIENTO A PAGINA PRINCIPAL
                                  }
                                  else
                                  {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'ADVERTENCIA',
                                      text: 'El correo y/o contraseña son incorrectos',
                                    );
                                  }
                                },
                                child: const Text(
                                  "Continuar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                ),
              )
            ],
          )
        )
    );
  }
}
