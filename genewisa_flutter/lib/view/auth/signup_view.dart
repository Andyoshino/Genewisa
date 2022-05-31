import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widget/auth_text_field_padding.dart';
import '../../theme/genewisa_text_theme.dart';
import '../../theme/genewisa_theme.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 271,
          height: 529,
          decoration: GenewisaTheme.authContainer(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Genewisa', 
                  style: GenewisaTextTheme.textTheme.headline1,
                ),
                const SizedBox(height: 20.0,),
                const Divider(color: Colors.black,),
                const SizedBox(height: 20.0,),
                AuthTextFieldPadding(hintText: 'Nama Lengkap'),
                AuthTextFieldPadding(hintText: 'Username'),
                AuthTextFieldPadding(hintText: 'Password'),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 21.5,
                    right: 21.5,
                    bottom: 17.0,
                  ),
                  child: Container(
                    decoration: GenewisaTheme.authButtonContainer(),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/login');
                        }
                      },
                      style: GenewisaTheme.geneButton(),
                      child: Text(
                        'Daftar',
                        style: GenewisaTextTheme.textTheme.button,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                RichText(
                  text: TextSpan(
                    style: GenewisaTextTheme.textTheme.bodyText1,
                    children: <TextSpan>[
                      const TextSpan(text: 'Punya akun? '),
                      TextSpan(
                        text: 'Login',
                        style: GenewisaTextTheme.textTheme.bodyText2,
                        recognizer: TapGestureRecognizer()
                          ..onTap=() {
                            Navigator.pushNamed(context, '/login');
                          } 
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}