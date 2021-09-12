import 'package:bag_of_words/bloc/auth/auth_bloc.dart';
import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:bag_of_words/data/repos/auth/auth_repo.dart';
import 'package:bag_of_words/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

  static Route route() => MaterialPageRoute<void>(builder: (_) => LoginPage());
}

class _LoginScreenState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState.status == AuthStatus.AUTHENTICATED) {
          Navigator.of(context).pushAndRemoveUntil(
            HomePage.route(),
            (route) => false,
          );
        }
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Bag of words',
                style: TextStyle(fontSize: 22.0),
              ),
              Column(
                children: [
                  SignInButton(
                    Buttons.GoogleDark,
                    onPressed: () async {
                      try {
                        await context.read<AuthRepo>().logIn();
                      } catch (e) {
                        print(e);
                        // TODO: Nitify user that there is a login failure
                      }
                    },
                  ),
                  Text('Sign up or sign in'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
