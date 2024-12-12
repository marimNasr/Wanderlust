
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wonderlustapp/feature/authentication/presentation/views/updatescreen.dart';
import 'feature/Home/presentation/views/home.dart';
import 'feature/authentication/auth_cubit.dart';
import 'feature/authentication/presentation/views/signIn.dart';
import 'feature/authentication/presentation/views/signUp.dart';
import 'feature/authentication/presentation/views/splachscreen.dart';
import 'feature/authentication/presentation/views/startscreen.dart';
import 'feature/home/home_cubit.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Wonderlust());
}

class Wonderlust extends StatefulWidget {
  const Wonderlust ({super.key});

  @override
  State<Wonderlust> createState() => _MyAppState();
}

class _MyAppState extends State<Wonderlust> {
  @override
  void initState() {
    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()), // Second cubit
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Splachscreen.routename: (context)=> const Splachscreen(),
          Startscreen.routename: (context) => const Startscreen(),
          SignIn.routeName: (context) => const SignIn(),
          SignUp.routeName: (context) => const SignUp(),
          homePage.routeName: (context) => const homePage(),
          Updatescreen.routename : (context) => const Updatescreen(),
        },
        initialRoute: SignIn.routeName,
      ),
    );
  }
}