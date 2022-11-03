import 'package:flutter/material.dart';
import 'package:my_gallery0/features/gallery/ui/gallery_screen.dart';
import 'package:my_gallery0/features/gallery/providers/gallery_provider.dart';
import 'package:my_gallery0/features/auth/ui/login_screen.dart';
import 'package:my_gallery0/features/auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';




void main()async {


  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider(),),
            ChangeNotifierProvider(create: (_) => GalleryProvider(),),
          ],


          child:const MyApp()



      ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget myWidget=const Scaffold(body: Center(child: CircularProgressIndicator()),);

  logInWithCached()async{
    if(
    await  Provider.of<AuthProvider>(context,listen: false).loginWithCached(context: context)
    ){
      setState(() {
        myWidget=const GalleryScreen();
      });

    }
    else{
      setState(() {
        myWidget=const LoginScreen();
      });

    }

  }
  @override
  void initState() {
    logInWithCached();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      color: Colors.white,

      home:


     // Home()

      myWidget
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}




