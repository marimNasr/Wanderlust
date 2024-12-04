import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/Authentication/presentation/views/signUp.dart';
import 'package:video_player/video_player.dart';
import '../../../../Constants/constant_color.dart';
import '../../../../Constants/constant_size.dart';
import '../cubit/auth_cubit.dart';
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
      }).catchError((error) {
        print("Video initialization error: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize.init_screenSize(context);
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
                aspectRatio: (screenSize.width) / (screenSize.height/3.5),
                child: VideoPlayer(_controller),
              )
            ),
      
            // Bottom container
            Positioned(
              top: screenSize.height/3.94,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(screenSize.width/3.3),
                  ),
                  color: lightOlive,
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width/20),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is SignInSuccess) {
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Sign In Success")),
                          );
                          Navigator.pushReplacementNamed(context, "/home");
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
                            SizedBox(height: screenSize.height/21),
                            Text(
                              "Sign In",
                              style: TextStyle(
                                color: mainColor,
                                fontSize: screenSize.width/9.9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenSize.height/29),
                            CustomTextfrom(
                              labelText: "Email",
                              controller: context.read<AuthCubit>().email,
                              fKey: fKey,
                              textColor: darkOlive,
                            ),
                            SizedBox(height: 20),
                            SecretTextform(
                              labelText: "Password",
                              controller: context.read<AuthCubit>().pass,
                              fKey: fKeyP,
                              controller_parent: null,
                              textColor: darkOlive,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("If you don't have an account"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, SignUp.routeName);
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: babyBlue,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            state is SignInLoading
                                ? const CircularProgressIndicator()
                                : MaterialButton(//198,149,65  147,188,203
                              color: orange,
                              onPressed: () {
                                if (fKey.currentState!.validate() &&
                                    fKeyP.currentState!.validate()) {
                                  context.read<AuthCubit>().signIn();
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: buttonsLabel,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const AnotherOptions(size: 10),
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
