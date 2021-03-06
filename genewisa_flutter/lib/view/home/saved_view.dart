import 'dart:convert';
import 'package:flutter/material.dart';
import '../widget/list_wisata_container.dart';
import '../../../model/tempatwisata_model.dart';
import '../../api/api.dart';
import '../../utils/PreferenceGlobal.dart';
import '../../view/home/detailwisata_view.dart';
import '../widget/list_wisata_saved_container.dart';

class SavedView extends StatefulWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  late List<TempatWisata> _allSavedWisata = <TempatWisata>[];

  initState() {
    _fetchSavedWisata();
    super.initState();
  }

  void getwisata(idx) async {
    final responsenya =
        await CallApi().getData('tempat-wisata/' + (idx.toString()));
    Map<String, dynamic> result =
        (json.decode(responsenya.body) as Map<String, dynamic>);
    setState(() {
      _allSavedWisata.add(TempatWisata.fromJson(result['data']));
    });
  }

  void _fetchSavedWisata() async {
    _allSavedWisata = <TempatWisata>[];
    var data = {'username': PreferenceGlobal.getPref().getString('username')};
    final response =
        await CallApi().getDataSaved('&&username=' + (data['username'] ?? ''));
    print(response.body);
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      setState(() {
        for (Map<String, dynamic> element in result) {
          getwisata(element['id_tempatwisata']);
        }
      });
    } else {
      throw Exception('Failed to load saved tempat wisata');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async { 
                    setState(() {
                      _fetchSavedWisata();
                    });
                  },
                  child: ListView.builder(
                    itemCount: _allSavedWisata.length,
                    itemBuilder: (context, index) => InkWell(
                  child: ListWisataSContainer(
                    nama: _allSavedWisata[index].name.toString(),
                    lokasi: _allSavedWisata[index].city.toString(),
                    url: _allSavedWisata[index].pictureUrl.toString(),
                  ),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => DetailWisataView(
                          foundWisata: _allSavedWisata[index],
                          showRating: false,
                        )
                      )
                    );
                  },
                  ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
