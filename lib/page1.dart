import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  void initState() {
    // TODO: implement initState
    setFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Geri Git'),
        ),
        body: FutureBuilder<String>(
          future: setFuture(),
          builder: (_, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return Text('Bağlantı Aktif');
              case ConnectionState.done:
                return resultWidget(snapshot);
              case ConnectionState.waiting:
                return Text('Bağlantı Bekliyor');
              case ConnectionState.none:
                return Text('Bağlantı Yok');
            }
          },
        ));
  }

  Future<String> setFuture() async {
    var url = Uri.parse('https://randomuser.me/api/?results=1');

    var response = await http.get(url);

    late var jsonResponse;
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      print(jsonResponse);
    } else {
      jsonResponse = response.statusCode;

      print('Request failed with status: ${response.statusCode}.');
    }
    return jsonResponse.toString();
  }

  Widget resultWidget(AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data.toString());
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    return const Text('bilinmeyen durum');
  }
}
