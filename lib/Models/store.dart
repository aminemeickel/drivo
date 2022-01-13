import 'package:collection/collection.dart';

class Store {
  final String? storeId;
  final String? userId;
  final String? storeName;
  final String? description;
  final String? fullAddress;
  final String? zipcode;
  final double? lat;
  final double? lng;
  final String? area;
  final String? city;
  final String? state;
  final String? country;
  final String? contactNumber;
  final bool? status;
  final String? bannerImage;
  final bool? active;
  final dynamic createdBy;
  final int? commisionRate;
  final String? deliveryType;
  final String? storeImage;
  final String? cityId;
  final String? stateId;
  final String? countryId;

  const Store({
    this.storeId,
    this.userId,
    this.storeName,
    this.description,
    this.fullAddress,
    this.zipcode,
    this.lat,
    this.lng,
    this.area,
    this.city,
    this.state,
    this.country,
    this.contactNumber,
    this.status,
    this.bannerImage,
    this.active,
    this.createdBy,
    this.commisionRate,
    this.deliveryType,
    this.storeImage,
    this.cityId,
    this.stateId,
    this.countryId,
  });

  @override
  String toString() {
    return 'Store(storeId: $storeId, userId: $userId, storeName: $storeName, description: $description, fullAddress: $fullAddress, zipcode: $zipcode, lat: $lat, lng: $lng, area: $area, city: $city, state: $state, country: $country, contactNumber: $contactNumber, status: $status, bannerImage: $bannerImage, active: $active, createdBy: $createdBy, commisionRate: $commisionRate, deliveryType: $deliveryType, storeImage: $storeImage, cityId: $cityId, stateId: $stateId, countryId: $countryId)';
  }

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeId: json['store_id'] as String?,
        userId: json['user_id'] as String?,
        storeName: json['store_name'] as String?,
        description: json['description'] as String?,
        fullAddress: json['full_address'] as String?,
        zipcode: json['zipcode'] as String?,
        lat: (json['lat'] as num?)?.toDouble(),
        lng: (json['lng'] as num?)?.toDouble(),
        area: json['area'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        country: json['country'] as String?,
        contactNumber: json['contact_number'] as String?,
        status: json['status'] as bool?,
        bannerImage: json['banner_image'] as String?,
        active: json['active'] as bool?,
        createdBy: json['created_by'] as dynamic,
        commisionRate: json['commision_rate'] as int?,
        deliveryType: json['delivery_type'] as String?,
        storeImage: json['store_image'] as String?,
        cityId: json['city_id'] as String?,
        stateId: json['state_id'] as String?,
        countryId: json['country_id'] as String?,
      );

  Map<String, dynamic> get toJson => {
        'store_id': storeId,
        'user_id': userId,
        'store_name': storeName,
        'description': description,
        'full_address': fullAddress,
        'zipcode': zipcode,
        'lat': lat,
        'lng': lng,
        'area': area,
        'city': city,
        'state': state,
        'country': country,
        'contact_number': contactNumber,
        'status': status,
        'banner_image': bannerImage,
        'active': active,
        'created_by': createdBy,
        'commision_rate': commisionRate,
        'delivery_type': deliveryType,
        'store_image': storeImage,
        'city_id': cityId,
        'state_id': stateId,
        'country_id': countryId,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Store) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson, toJson);
  }

  @override
  int get hashCode =>
      storeId.hashCode ^
      userId.hashCode ^
      storeName.hashCode ^
      description.hashCode ^
      fullAddress.hashCode ^
      zipcode.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      area.hashCode ^
      city.hashCode ^
      state.hashCode ^
      country.hashCode ^
      contactNumber.hashCode ^
      status.hashCode ^
      bannerImage.hashCode ^
      active.hashCode ^
      createdBy.hashCode ^
      commisionRate.hashCode ^
      deliveryType.hashCode ^
      storeImage.hashCode ^
      cityId.hashCode ^
      stateId.hashCode ^
      countryId.hashCode;
}
