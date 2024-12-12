import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wonderlustapp/feature/authentication/presentation/views/signUp.dart';
import 'package:wonderlustapp/feature/home/home_cubit.dart';
import '../../../../constant/constants.dart';
import '../../../Home/presentation/views/home.dart';
import '../../auth_cubit.dart';
import '../widgets/Options.dart';
import '../widgets/custom_TextFrom.dart';
import '../widgets/secret_textForm.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  static String routeName = "sign_in";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  GlobalKey<FormState> fKeyP = GlobalKey<FormState>();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/signin.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {}); // Refresh UI after initialization
          _controller.play();
          _controller.setLooping(true);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: videoColor,
        body: Stack(
          children: [
      
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child:AspectRatio(
                aspectRatio: (ScreenSize.width) / (ScreenSize.height/3.5),
                child: VideoPlayer(_controller),
              )
            ),
      
            // Bottom container
            Positioned(
              top: ScreenSize.height/3.94,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ScreenSize.width/3.3),
                  ),
                  color: mainColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(ScreenSize.width/20),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is SignInSuccess) {
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Sign In Success")),
                          );
                          
                          Navigator.pushReplacementNamed(context,
                           homePage.routeName,
                           arguments:{'categoryModel': context.read<HomeCubit>().getAttractions() } );
                          
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please Verify Your Email")),
                          );
                        }
                      } else if (state is SignInError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: ScreenSize.height/21),
                            Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenSize.width/9.9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: ScreenSize.height/29),
                            CustomTextfrom(
                              labelText: "Email",
                              controller: context.read<AuthCubit>().email,
                              fKey: fKey,
                              textColor: darkOlive,
                            ),
                            SizedBox(height: ScreenSize.height/42),
                            SecretTextform(
                              labelText: "Password",
                              controller: context.read<AuthCubit>().pass,
                              fKey: fKeyP,
                              controller_parent: null,
                              textColor: darkOlive,
                            ),
                            SizedBox(height: ScreenSize.height/42),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("If you don't have an account",
                                    style: TextStyle(color: darkOlive)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, SignUp.routeName);
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 200, 119, 59),
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenSize.width/26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: ScreenSize.height/82),
                            state is SignInLoading
                                ? const CircularProgressIndicator()
                                : MaterialButton(
                              color: orange,
                              onPressed: () {
                                if (fKey.currentState!.validate() &&
                                    fKeyP.currentState!.validate()) {
                                  context.read<AuthCubit>().signIn();
                                 
                                }
                              }, 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ScreenSize.width/15),
                              ),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: buttonsLabel,
                                  fontSize: ScreenSize.width/18,
                                ),
                              ),
                            ),
                            SizedBox(height: ScreenSize.height/42),
                            AnotherOptions(size: ScreenSize.height/82),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}