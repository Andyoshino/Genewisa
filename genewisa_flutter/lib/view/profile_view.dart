import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/genewisa_text_theme.dart';
import '../theme/genewisa_theme.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 168,
              margin: const EdgeInsets.only(top: 20, bottom: 15, left: 30, right: 30),
              decoration: GenewisaTheme.tileContainer(color: const Color(0xFFFFEE57)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 55,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Asep', style: GenewisaTextTheme.textTheme.headline2,),
                      Text('Surasep', style: GenewisaTextTheme.textTheme.headline2,),
                      Text('asepsur', style: GenewisaTextTheme.textTheme.bodyText1,),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 135,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 15, left: 30, right: 30),
              decoration: GenewisaTheme.tileContainer(),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(
                      'statistic_icon.svg',
                      semanticsLabel: 'Statistic Icon',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('7', style: GenewisaTextTheme.textTheme.headlineLarge,),
                          Text('Dikunjungi', style: GenewisaTextTheme.textTheme.bodyText1,),
                        ],
                      ),
                      const SizedBox(width: 50,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('5', style: GenewisaTextTheme.textTheme.headlineLarge,),
                          Text('Review', style: GenewisaTextTheme.textTheme.bodyText1,),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}