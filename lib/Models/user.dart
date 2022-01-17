import 'package:collection/collection.dart';

class User {
  String? uid;
  String? fullname;
  String? mobile;
  String? picture;
  String? lang;
  bool? isValid;
  String? level;
  String? createdAt;

  User({
    this.uid,
    this.fullname,
    this.mobile,
    this.picture,
    this.lang,
    this.isValid,
    this.level,
    this.createdAt,
  });

  @override
  String toString() {
    return 'User(uid: $uid, fullname: $fullname, mobile: $mobile, picture: $picture, lang: $lang, isValid: $isValid, level: $level, createdAt: $createdAt)';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'] as String?,
        fullname: json['fullname'] as String?,
        mobile: json['mobile'] as dynamic,
        picture: json['picture'] as dynamic,
        lang: json['lang'] as String?,
        isValid: json['is_valid'] as bool?,
        level: json['level'] as String?,
        createdAt: json['created_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'fullname': fullname,
        'mobile': mobile,
        'picture': picture,
        'lang': lang,
        'is_valid': isValid,
        'level': level,
        'created_at': createdAt,
      };

  User copyWith({
    String? uid,
    String? fullname,
    dynamic mobile,
    dynamic picture,
    String? lang,
    bool? isValid,
    String? level,
    String? createdAt,
  }) {
    return User(
      uid: uid ?? this.uid,
      fullname: fullname ?? this.fullname,
      mobile: mobile ?? this.mobile,
      picture: picture ?? this.picture,
      lang: lang ?? this.lang,
      isValid: isValid ?? this.isValid,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      fullname.hashCode ^
      mobile.hashCode ^
      picture.hashCode ^
      lang.hashCode ^
      isValid.hashCode ^
      level.hashCode ^
      createdAt.hashCode;
}
