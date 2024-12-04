import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/Authentication/presentation/views/signIn.dart';
import '../../../../Constants/constant_color.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/Options.dart';
import '../widgets/custom_TextFrom.dart';
import '../widgets/secret_textForm.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static String routeName = "sign_up";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> cfKeyP = GlobalKey<FormState>();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  GlobalKey<FormState> fKeyP = GlobalKey<FormState>();
  GlobalKey<FormState> fKeyn = GlobalKey<FormState>();
  GlobalKey<FormState> fKeyph = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightOlive,
        body: Stack( // Using Stack to position the back button
          children: [

     SingleChildScrollView(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is SignUpSuccess){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Sign Up Success, verify your email")),
                );
              Navigator.pushReplacementNamed(context, SignIn.routeName);
            }else if (state is SignInError){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.error)
                )
              );
            }
          },
        builder: (context, state) {
        return Stack(
          children: [
            Column(
                  children: [
                    const SizedBox(height: 40),
                    const Row(
                      children: [
                        SizedBox(width: 25),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                "Create",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Account",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                                        ),
                                      ]
                                    ),

                                SizedBox(width: 7.7,),
                                Image(image: AssetImage('assets/hotairballoon.png'),height: 190, width: 190),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 80),
                            CustomTextfrom(
                              labelText: "Name",
                              controller: context.read<AuthCubit>().nameup,
                              fKey: fKeyn,
                              textColor: darkOlive,
                            ),
                            const SizedBox(height: 20),
                            CustomTextfrom(
                              labelText: "Email",
                              controller: context.read<AuthCubit>().emailup,
                              fKey: fKey,
                              textColor: darkOlive,
                            ),
                            const SizedBox(height: 20),
                            SecretTextform(
                              labelText: "Password",
                              controller: context.read<AuthCubit>().passup,
                              fKey: fKeyP,
                              controller_parent: null,
                              textColor: darkOlive,
                            ),
                            const SizedBox(height: 20),
                            SecretTextform(
                              labelText: "Confirm Password",
                              controller: context.read<AuthCubit>().cpassup,
                              fKey: cfKeyP,
                              controller_parent: context.read<AuthCubit>().passup,
                              textColor: darkOlive,
                            ),

                            const SizedBox(height: 70),
                             state is SignUpLoading ? const CircularProgressIndicator() : MaterialButton(
                              color: orange,
                              minWidth: 150,
                              onPressed: () {
                                if (fKey.currentState!.validate() &&
                                    fKeyP.currentState!.validate() &&
                                    cfKeyP.currentState!.validate() &&
                                    fKeyn.currentState!.validate()) {
                                  context.read<AuthCubit>().signUp();

                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: buttonsLabel,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                    Positioned( // Back button positioned at the top left
                      top: 5,
                      left: 5,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: darkOlive),
                        onPressed: () {
                          Navigator.of(context).pop(); // Go back to the previous screen
                        },
                      ),
                    ),
                  ],
                );
  },
),)
          ],
        ),
      ),
    );
  }
}
