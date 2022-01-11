import 'package:collection/collection.dart';

class Order {
  int? lat;
  int? lng;
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

  Order({
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
  });

  @override
  String toString() {
    return 'Order(lat: $lat, lng: $lng, discNominal: $discNominal, scheduleAt: $scheduleAt, orderNumber: $orderNumber, rating: $rating, comment: $comment, detailOrders: $detailOrders, transportation: $transportation, transportationModel: $transportationModel, colour: $colour, licensePlate: $licensePlate, pickupType: $pickupType, storeName: $storeName, buyer: $buyer, couponCode: $couponCode, couponName: $couponName)';
  }

  factory Order.fromJson(Map<String, dynamic> data) => Order(
        lat: data['lat'] as int?,
        lng: data['lng'] as int?,
        discNominal: data['disc_nominal'] as int?,
        scheduleAt: data['schedule_at'] as String?,
        orderNumber: data['order_number'] as String?,
        rating: data['rating'] as int?,
        comment: data['comment'] as dynamic,
        detailOrders: data['detail_orders'] as dynamic,
        transportation: data['transportation'] as String?,
        transportationModel: data['transportation_model'] as String?,
        colour: data['colour'] as String?,
        licensePlate: data['license_plate'] as String?,
        pickupType: data['pickup_type'] as String?,
        storeName: data['store_name'] as String?,
        buyer: data['buyer'] as String?,
        couponCode: data['coupon_code'] as dynamic,
        couponName: data['coupon_name'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
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
