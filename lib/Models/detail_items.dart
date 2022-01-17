import 'package:collection/collection.dart';
import 'package:get/get.dart';

class DetailItem {
  String? id;
  String? itemId;
  String? itemName;
  int? qty;
  int? price;
  int? netto;
  String? picture;
  dynamic itemDetail;
  List<Extra>? extras;
  RxBool isSlected = true.obs;

  DetailItem({
    this.id,
    this.itemId,
    this.itemName,
    this.qty,
    this.price,
    this.netto,
    this.picture,
    this.itemDetail,
    this.extras,
  });

  @override
  String toString() {
    return 'DetailItem(id: $id, itemId: $itemId, itemName: $itemName, qty: $qty, price: $price, netto: $netto, picture: $picture, itemDetail: $itemDetail, extras: $extras)';
  }

  factory DetailItem.fromJson(Map<String, dynamic> json) => DetailItem(
        id: json['id'] as String?,
        itemId: json['item_id'] as String?,
        itemName: json['item_name'] as String?,
        qty: json['qty'] as int?,
        price: json['price'] as int?,
        netto: json['netto'] as int?,
        picture: json['picture'] as String?,
        itemDetail: json['item_detail'] as dynamic,
        extras: (json['extras'] as List<dynamic>?)
            ?.map((e) => Extra.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'item_id': itemId,
        'item_name': itemName,
        'qty': qty,
        'price': price,
        'netto': netto,
        'picture': picture,
        'item_detail': itemDetail,
        'extras': extras?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DetailItem) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      itemId.hashCode ^
      itemName.hashCode ^
      qty.hashCode ^
      price.hashCode ^
      netto.hashCode ^
      picture.hashCode ^
      itemDetail.hashCode ^
      extras.hashCode;
}

class Extra {
  String? addonId;
  String? name;
  int? qty;
  int? price;
  int? netto;

  Extra({this.addonId, this.name, this.qty, this.price, this.netto});

  @override
  String toString() {
    return 'Extra(addonId: $addonId, name: $name, qty: $qty, price: $price, netto: $netto)';
  }

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        addonId: json['addon_id'] as String?,
        name: json['name'] as String?,
        qty: json['qty'] as int?,
        price: json['price'] as int?,
        netto: json['netto'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'addon_id': addonId,
        'name': name,
        'qty': qty,
        'price': price,
        'netto': netto,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Extra) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      addonId.hashCode ^
      name.hashCode ^
      qty.hashCode ^
      price.hashCode ^
      netto.hashCode;
}
