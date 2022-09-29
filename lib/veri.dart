void main() {
  // ignore: unused_local_variable
  Map<String, dynamic> myMap = {
    "ad": "Ali",
    "soyad": "Şengül",
    "adres": [
      {
        "ulke": "Türkiye",
        "sehir": "İzmir",
        "ilce": "Bayraklı",
      },
    ],
  };
  var obj = Personel.fromJson(myMap);
  var myAdres = obj.adres;
  myAdres!.map((e) {
    //print("${e.ilce}");
  }).toList();
}

class Personel {
  String? ad;
  String? soyad;
  List<Adres>? adres;

  Personel({this.ad, this.soyad, this.adres});

  Personel.fromJson(Map<String, dynamic> json) {
    ad = json["ad"];
    soyad = json["soyad"];
    if (json["adres"] != null) {
      adres = <Adres>[];
      // ignore: avoid_function_literals_in_foreach_calls
      (json["adres"] as List).forEach((e) {
        adres!.add(Adres.fromJson(e));
      });
    }
  }
}

class Adres {
  String? ulke;
  String? sehir;
  String? ilce;

  Adres({this.ulke, this.sehir, this.ilce});

  Adres.fromJson(Map<String, dynamic> json) {
    ulke = json["ulke"];
    sehir = json["sehir"];
    ilce = json['ilce'];
  }
}
