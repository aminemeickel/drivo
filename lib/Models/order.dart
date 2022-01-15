import 'package:collection/collection.dart';
import 'package:drivo/Models/detail_items.dart';

class Order {
  String? orderId;
  String? userId;
  String? storeId;
  String? createdAt;
  String? orderType;
  dynamic coupon;
  int? disc;
  int? brutto;
  int? netto;
  String? payment;
  String? status;
  dynamic lat;
  dynamic lng;
  int? discNominal;
  String? scheduleAt;
  String? orderNumber;
  int? rating;
  dynamic comment;
  dynamic detailOrders;
  String? transportation;
  String? transportationModel;
  String? colour;
  String? licensePlate;
  String? pickupType;
  String? storeName;
  String? buyer;
  dynamic couponCode;
  dynamic couponName;
  Iterable<DetailItem>? detailItem;

  Order(
      {this.orderId,
      this.userId,
      this.storeId,
      this.createdAt,
      this.orderType,
      this.coupon,
      this.disc,
      this.brutto,
      this.netto,
      this.payment,
      this.status,
      this.lat,
      this.lng,
      this.discNominal,
      this.scheduleAt,
      this.orderNumber,
      this.rating,
      this.comment,
      this.detailOrders,
      this.transportation,
      this.transportationModel,
      this.colour,
      this.licensePlate,
      this.pickupType,
      this.storeName,
      this.buyer,
      this.couponCode,
      this.couponName,
      this.detailItem});

  @override
  String toString() {
    return 'Order(orderId: $orderId, userId: $userId, storeId: $storeId, createdAt: $createdAt, orderType: $orderType, coupon: $coupon, disc: $disc, brutto: $brutto, netto: $netto, payment: $payment, status: $status, lat: $lat, lng: $lng, discNominal: $discNominal, scheduleAt: $scheduleAt, orderNumber: $orderNumber, rating: $rating, comment: $comment, detailOrders: $detailOrders, transportation: $transportation, transportationModel: $transportationModel, colour: $colour, licensePlate: $licensePlate, pickupType: $pickupType, storeName: $storeName, buyer: $buyer, couponCode: $couponCode, couponName: $couponName items : $detailItem)';
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      orderId: json['order_id'] as String?,
      userId: json['user_id'] as String?,
      storeId: json['store_id'] as String?,
      createdAt: json['created_at'] as String?,
      orderType: json['order_type'] as String?,
      coupon: json['coupon'] as dynamic,
      disc: json['disc'] as int?,
      brutto: json['brutto'] as int?,
      netto: json['netto'] as int?,
      payment: json['payment'] as String?,
      status: json['status'] as String?,
      lat: json['lat'] as dynamic,
      lng: json['lng'] as dynamic,
      discNominal: json['disc_nominal'] as int?,
      scheduleAt: json['schedule_at'] as String?,
      orderNumber: json['order_number'] as String?,
      rating: json['rating'] as int?,
      comment: json['comment'] as dynamic,
      detailOrders: json['detail_orders'] as dynamic,
      transportation: json['transportation'] as String?,
      transportationModel: json['transportation_model'] as String?,
      colour: json['colour'] as String?,
      licensePlate: json['license_plate'] as String?,
      pickupType: json['pickup_type'] as String?,
      storeName: json['store_name'] as String?,
      buyer: json['buyer'] as String?,
      couponCode: json['coupon_code'] as dynamic,
      couponName: json['coupon_name'] as dynamic,
      detailItem: json['detail_item'] != null
          ? (json['detail_item'] as List)
              .map((json) => DetailItem.fromJson(json))
          : null);

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'user_id': userId,
        'store_id': storeId,
        'created_at': createdAt,
        'order_type': orderType,
        'coupon': coupon,
        'disc': disc,
        'brutto': brutto,
        'netto': netto,
        'payment': payment,
        'status': status,
        'lat': lat,
        'lng': lng,
        'disc_nominal': discNominal,
        'schedule_at': scheduleAt,
        'order_number': orderNumber,
        'rating': rating,
        'comment': comment,
        'detail_orders': detailOrders,
        'transportation': transportation,
        'transportation_model': transportationModel,
        'colour': colour,
        'license_plate': licensePlate,
        'pickup_type': pickupType,
        'store_name': storeName,
        'buyer': buyer,
        'coupon_code': couponCode,
        'coupon_name': couponName,
        'detail_item': detailItem?.map((e) => e.toJson()).toList()
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Order) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      orderId.hashCode ^
      userId.hashCode ^
      storeId.hashCode ^
      createdAt.hashCode ^
      orderType.hashCode ^
      coupon.hashCode ^
      disc.hashCode ^
      brutto.hashCode ^
      netto.hashCode ^
      payment.hashCode ^
      status.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      discNominal.hashCode ^
      scheduleAt.hashCode ^
      orderNumber.hashCode ^
      rating.hashCode ^
      comment.hashCode ^
      detailOrders.hashCode ^
      transportation.hashCode ^
      transportationModel.hashCode ^
      colour.hashCode ^
      licensePlate.hashCode ^
      pickupType.hashCode ^
      storeName.hashCode ^
      buyer.hashCode ^
      couponCode.hashCode ^
      couponName.hashCode;
}
