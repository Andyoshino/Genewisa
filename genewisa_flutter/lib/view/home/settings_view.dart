import 'package:flutter/material.dart';
import 'package:genewisa_flutter/view/home/home_view.dart';
import '../../theme/genewisa_text_theme.dart';
import '../../theme/genewisa_theme.dart';
import '../widget/setting_text_field.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 100,
        leadingWidth: 100,
        title: Row(
          children: <Widget>[
            IconButton(
              iconSize: 35,
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Settings',
              style: GenewisaTextTheme.textTheme.headline2,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black,
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images-ext-1.discordapp.net/external/8cWjK0gRjXAALR4npR2qYFVscpnJEkFoyWBAVQszngQ/%3Fsize%3D1024/https/cdn.discordapp.com/avatars/707445135318974515/93ac9643a293a7ae11b3375beb63fc44.png?width=480&height=480"),
                      radius: 98,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SettingTextField(hintText: "Nama lengkap"),
                      SettingTextField(hintText: "Username"),
                      SettingTextField(hintText: "Password Lama"),
                      SettingTextField(hintText: "Password Baru"),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 140,
                            height: 53,
                            decoration: GenewisaTheme.cancelButtonContainer(),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: GenewisaTheme.geneButton(),
                              child: Text(
                                'Batal',
                                style: GenewisaTextTheme.textTheme.button,
                              ),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 53,
                            decoration: GenewisaTheme.buttonContainer(),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //Navigator.pushNamed(context, '/');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomeView())
                                  );
                                }
                              },
                              style: GenewisaTheme.geneButton(),
                              child: Text(
                                'Simpan',
                                style: GenewisaTextTheme.textTheme.button,
                              ),
                            ),
                          ),
                        ],
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
