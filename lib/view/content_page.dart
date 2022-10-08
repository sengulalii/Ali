// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../helper/page_helper.dart';
import '../viewmodel/content_viewmodel.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> with PageHelper {
  //var color;
  @override
  void initState() {
    printPageData("ContentPage");
    Provider.of<ContentViewModel>(context, listen: false).removeUsers();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ContentViewModel>(context, listen: false).get5Users();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contentViewModel = Provider.of<ContentViewModel>(context, listen: true);
    return WillPopScope(
      onWillPop: () {
        Provider.of<ContentViewModel>(context, listen: false)
            .statusMap[Services.users5] = ServiceStatus.idle;
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: color,
          appBar: AppBar(
            title: const Text('Geri Git'),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    color = Colors.blue;
                  });
                },
                icon: Icon(Icons.change_circle),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<ContentViewModel>(context, listen: false)
                      .removeLast();
                },
                icon: Icon(Icons.minimize_outlined),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<ContentViewModel>(context, listen: false)
                      .clearUsers();
                },
                icon: Icon(Icons.cancel),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<ContentViewModel>(context, listen: false)
                      .get10Users();
                },
                icon: Icon(Icons.download),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /*  Expanded(
                  child: Column(
                children: [],
              )), */
              Expanded(
                child: (contentViewModel.statusMap[Services.users5] ==
                        ServiceStatus.idle)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : dataList(),
                // TODO add radio button, mixin

                /* FutureBuilder<String>(
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
                ), */
              ),
            ],
          )),
    );
  }

  Widget dataWidget() {
    var contentViewModel = Provider.of<ContentViewModel>(context, listen: true);

    switch (contentViewModel.statusMap[Services.users5]) {
      case ServiceStatus.inProgress:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ServiceStatus.completed:
        return dataList();
      case ServiceStatus.error:
        return const Center(
          child: Icon(Icons.error),
        );
      case ServiceStatus.idle:
      default:
        return const SizedBox();
    }
  }

  Widget dataList() {
    var contentViewModel = Provider.of<ContentViewModel>(context, listen: true);

    return ListView.builder(
      itemCount: contentViewModel.users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: contentViewModel.users[index].picture == null
              ? const Icon(Icons.image)
              : CircleAvatar(
                  backgroundImage:
                      NetworkImage(contentViewModel.users[index].picture!),
                ),
          title: Text(contentViewModel.users[index].picture!),
        );
      },
    );
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

  Widget resultWidget(AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData) {
      return Text(snapshot.data.toString());
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    return const Text('bilinmeyen durum');
  }

/*   Widget resultWidget2(AsyncSnapshot<String> snapshot) {
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
              title: Text(users[index].picture!),
            );
          });
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    return const Text('bilinmeyen durum');
  } */
}
