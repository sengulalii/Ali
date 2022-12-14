// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
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

        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: color,
          appBar: AppBar(
            title: const Text('Geri Git'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, Colors.green);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, 4);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
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
                  try {
                    Provider.of<ContentViewModel>(context, listen: false)
                        .get10Users();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Hata"),
                      ),
                    );
                  }
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
                        return const Text('Ba??lant?? Aktif');
                      case ConnectionState.done:
                        return resultWidget2(snapshot);
                      case ConnectionState.waiting:
                        return const Text('Ba??lant?? Bekliyor');
                      case ConnectionState.none:
                        return const Text('Ba??lant?? Yok');
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
