import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Constants/constant_color.dart';
import '../../../../Constants/constant_size.dart';
import '../../../Home/presentation/views/home.dart';
import '../cubit/auth_cubit.dart';

class AnotherOptions extends StatelessWidget {
  const AnotherOptions({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text("~OR~"
            , style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenSize.width/19
            ),),
          SizedBox(height: size),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is GoogleSignInSuccess){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Sign In Success")),
                );
                Navigator.pushReplacementNamed(context, homePage.routeName);
              }else if (state is GoogleSignInError){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(state.error)
                  )
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().signInWithGoogle();

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenSize.width/15), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenSize.height/100, horizontal: screenSize.width/30), // Adjust padding
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.g_mobiledata,
                      color: buttonsLabel, // Google icon color
                      size: screenSize.width/12, // Adjust icon size
                    ),
                    SizedBox(width: screenSize.width/55 ), // Space between icon and text
                    Text(
                      "Sign in with Google",
                      style: TextStyle(
                        color: buttonsLabel, // Text color
                        fontSize: screenSize.width/24, // Text size
                      ),
                    ),
                  ],
                ),
              );

            },
          ),
        ]
    );
  }
}
