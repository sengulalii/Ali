// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/name.dart';
import 'model/user.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<User> users = [];

  @override
  void initState() {
    //setFuture1();
    //setFuture2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Geri Git'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FutureBuilder<String>(
                future: setFuture1(),
                builder: (_, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return const Text('Bağlantı Aktif');
                    case ConnectionState.done:
                      return resultWidget(snapshot);
                    case ConnectionState.waiting:
                      return const Text('Bağlantı Bekliyor');
                    case ConnectionState.none:
                      return const Text('Bağlantı Yok');
                  }
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<String>(
                future: setFuture2(),
                builder: (_, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return const Text('Bağlantı Aktif');
                    case ConnectionState.done:
                      return resultWidget2(snapshot);
                    case ConnectionState.waiting:
                      return const Text('Bağlantı Bekliyor');
                    case ConnectionState.none:
                      return const Text('Bağlantı Yok');
                  }
                },
              ),
            ),
          ],
        ));
  }

  Future<String> setFuture1() async {
    var url = Uri.parse('https://randomuser.me/api/?results=1');

    var response = await http.get(url);

    late var jsonResponse;
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      jsonResponse = response.statusCode;
    }
    return jsonResponse.toString();
  }

  Future<String> setFuture2() async {
    var url = Uri.parse('https://randomuser.me/api/?results=5');

    var response = await http.get(url);

    late var jsonResponse;
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var i = 0; i < jsonResponse["results"].length; i++) {
        /*if (i == 1) {
          jsonResponse["results"][i]["picture"] = null;
        }*/
        var currentUser = User.fromMap(jsonResponse["results"][i]);
        users.add(currentUser);
      }
    } else {
      jsonResponse = response.statusCode;

      //print('Request failed with status: ${response.statusCode}.');
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

  Widget resultWidget2(AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: users[index].picture == null
                  ? const Icon(Icons.image)
                  : CircleAvatar(
                      backgroundImage: NetworkImage(users[index].picture!),
                    ),
              title: Text(users[index].name!.first ?? "Hata"),
              subtitle: Text(users[index].name!.last ?? "Hata"),
            );
          });
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    return const Text('bilinmeyen durum');
  }
}
