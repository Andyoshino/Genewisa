import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genewisa_flutter/view/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/genewisa_text_theme.dart';
import '../../api/api.dart';
import '../../theme/genewisa_theme.dart';
import '../../utils/PreferenceGlobal.dart';
import '../widget/setting_text_field.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  final _formKey = GlobalKey<FormState>();
  String? username, firstName, lastName, img;
  TextEditingController namaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordlamaController = TextEditingController();
  TextEditingController passwordbaruController = TextEditingController();

  _showMsg(msg, Color clr) {
    //
    final snackBar = SnackBar(
      backgroundColor: clr,
      content: Text(msg, style: GenewisaTextTheme.textTheme.headline4),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Tutup',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getUser() async {
    var data = {
      'token': PreferenceGlobal.getPref().getString('token'),
      'username': PreferenceGlobal.getPref().getString('username')
    };

    var res = await CallApi().getData('user/' + (data['username'] ?? ''));
    var body = json.decode(res.body);
    await PreferenceGlobal.getPref().setString('first_name', body['data']['first_name'] ?? "");
    await PreferenceGlobal.getPref().setString('last_name', body['data']['last_name'] ?? "");
    await PreferenceGlobal.getPref().setString('img', body['data']['img'] ?? "");

    setState(() {
      username = PreferenceGlobal.getPref().getString('username');
      firstName = PreferenceGlobal.getPref().getString('first_name');
      lastName = PreferenceGlobal.getPref().getString('last_name');
      img = PreferenceGlobal.getPref().getString('img');
    });
    namaController =
        TextEditingController(text: '$firstName $lastName');
    usernameController =
        TextEditingController(text: username);
  }

  @override
  void initState() {
    getUser();
  }

  bool _isLoading = false;

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
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(img ?? ''),
                      radius: 98,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SettingTextField(
                        hintText: "Nama lengkap",
                        textController: namaController,
                        visibility: true,
                      ),
                      SettingTextField(
                        hintText: "Username",
                        textController: usernameController,
                        visibility: true,
                      ),
                      SettingTextField(
                        hintText: "Password Lama",
                        textController: passwordlamaController,
                        visibility: false,
                      ),
                      SettingTextField(
                        hintText: "Password Baru",
                        textController: passwordbaruController,
                        visibility: false,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 140,
            height: 53,
            margin: const EdgeInsets.only(bottom: 20),
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
            margin: const EdgeInsets.only(bottom: 20),
            decoration: GenewisaTheme.buttonContainer(),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _update();
                }
              },
              style: GenewisaTheme.geneButton(),
              child: Text(
                _isLoading ? 'Memperbaharui akun...' : 'Simpan',
                style: GenewisaTextTheme.textTheme.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _update() async {
    setState(() {
      _isLoading = true;
    });
    List<String> name = namaController.text.split(" ");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var firstName, lastName;
    firstName = name[0];
    if (name.length > 1) {
      lastName = name.sublist(1, name.length).join(" ");
    }

    var data = {
      'username': usernameController.text,
      'first_name': firstName,
      'last_name': lastName,
      'passwordlama': passwordlamaController.text,
      'passwordbaru': passwordbaruController.text,
    };

    var res = await CallApi().putData(data, 'user/' + (localStorage.getString('username') ?? ''));
    var body = json.decode(res.body);
    if (body['status'] == 'OK') {
      localStorage.setString('username', body['data']['username']);
      _showMsg("Berhasil memperbaharui", Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeView()));
    } else {
      _showMsg(body['error'][0], Colors.red);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
