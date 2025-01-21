import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/profile/fav_cubit.dart';
import 'features/Home/presentation/views/home.dart';
import 'features/authentication/auth_cubit.dart';
import 'features/authentication/presentation/views/signIn.dart';
import 'features/authentication/presentation/views/signUp.dart';
import 'features/authentication/presentation/views/startscreen.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/profile/views/updatescreen.dart';
import 'features/splashScreen/views/splachscreen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp ({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => FavCubit()),
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
