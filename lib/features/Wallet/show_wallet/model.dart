part of 'bloc.dart';

class WalletData {
  late final List<WalletModel> list;

  late final double wallet;

  WalletData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data']??[]).map((e) => WalletModel.fromJson(e)).toList();

    wallet = double.tryParse(json['wallet'].toString())??0;
  }
}

class WalletModel {
  late final int id;
  late final double amount;
  late final double beforeCharge;
  late final double afterCharge;
  late final String date;
  late final String statusTrans;
  late final String status;
  late final String transactionType;
  late final String modelType;
  late final int modelId;
  late final String state;
  late final List<Images> images;

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    amount = double.tryParse(json['amount'].toString())??0;
    beforeCharge = double.tryParse(json['before_charge'].toString())??0;
    afterCharge = double.tryParse(json['after_charge'].toString())??0;
    date = json['date']??"";
    statusTrans = json['status_trans']??"";
    status = json['status']??"";
    transactionType = json['transaction_type']??"";
    modelType = json['model_type']??"";
    modelId = json['model_id']??0;
    state = json['state']??"";
    images = List.from(json['images']??[]).map((e) => Images.fromJson(e)).toList();
  }
}

class Images {
  late final String name;
  late final String url;

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name']??"";
    url = json['url']??"";
  }
}
