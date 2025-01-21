import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/authentication/presentation/views/signIn.dart';
import '../../../../Constants/constant_color.dart';
import '../../../../Constants/constant_size.dart';
import '../../auth_cubit.dart';
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
    screenSize.init_screenSize(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: orange,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenSize.width/2.5),
            ),
            color: mainColor,
          ),
          child: Stack( // Using Stack to position the back button
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
                      SizedBox(height: screenSize.height/10.3),
                      Row(
                        children: [
                          SizedBox(width: screenSize.width/7),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                  "Create",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenSize.width/10.6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Account",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenSize.width/10.6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                          ),
                                        ]
                                      ),

                                  SizedBox(width: screenSize.width/62,),
                                  Image(image: AssetImage('assets/hotairballoon.png'),height: screenSize.height/4),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: screenSize.height/200),
                              Padding(
                                padding: EdgeInsets.all(screenSize.width/20),
                                child: Column(
                                  children: [
                                    CustomTextfrom(
                                      labelText: "Name",
                                      controller: context.read<AuthCubit>().nameup,
                                      fKey: fKeyn,
                                      textColor: darkOlive,
                                    ),
                                    SizedBox(height: screenSize.height/42 ),
                                    CustomTextfrom(
                                      labelText: "Email",
                                      controller: context.read<AuthCubit>().emailup,
                                      fKey: fKey,
                                      textColor: darkOlive,
                                    ),
                                    SizedBox(height: screenSize.height/42 ),
                                    SecretTextform(
                                      labelText: "Password",
                                      controller: context.read<AuthCubit>().passup,
                                      fKey: fKeyP,
                                      controller_parent: null,
                                      textColor: darkOlive,
                                    ),
                                    SizedBox(height: screenSize.height/42 ),
                                    SecretTextform(
                                      labelText: "Confirm Password",
                                      controller: context.read<AuthCubit>().cpassup,
                                      fKey: cfKeyP,
                                      controller_parent: context.read<AuthCubit>().passup,
                                      textColor: darkOlive,
                                    ),

                                  ],
                                ),
                              ),

                              SizedBox(height: screenSize.height/20),
                               state is SignUpLoading ? const CircularProgressIndicator() : MaterialButton(
                                color: orange,
                                minWidth: screenSize.width/2.6,
                                onPressed: () {
                                  if (fKey.currentState!.validate() &&
                                      fKeyP.currentState!.validate() &&
                                      cfKeyP.currentState!.validate() &&
                                      fKeyn.currentState!.validate()) {
                                    context.read<AuthCubit>().signUp();

                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenSize.width/15),
                                ),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: buttonsLabel,
                                    fontSize: screenSize.width/18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      Positioned( // Back button positioned at the top left
                        top: screenSize.height/50,
                        left: screenSize.width/80,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
      ),
    );
  }
}
