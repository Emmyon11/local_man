import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String fullName;
  final String personalAdress;
  final int age;
  final String uid;
  final List<String> profession;
  final String companyName;
  final String companyAddress;
  final String discription;
  final String email;
  final String phoneNo;
  final List<String> customers;
  final List<String> reviews;
  final String profilePic;
  final List<String> showcaseImg;
  UserModel({
    required this.fullName,
    required this.personalAdress,
    required this.age,
    required this.uid,
    required this.profession,
    required this.companyName,
    required this.companyAddress,
    required this.discription,
    required this.email,
    required this.phoneNo,
    required this.customers,
    required this.reviews,
    required this.profilePic,
    required this.showcaseImg,
  });

  UserModel copyWith({
    String? fullName,
    String? lastName,
    String? personalAdress,
    int? age,
    String? uid,
    List<String>? profession,
    String? companyName,
    String? companyAddress,
    String? discription,
    String? email,
    String? phoneNo,
    List<String>? customers,
    List<String>? reviews,
    String? profilePic,
    List<String>? showcaseImg,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      personalAdress: personalAdress ?? this.personalAdress,
      age: age ?? this.age,
      uid: uid ?? this.uid,
      profession: profession ?? this.profession,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      discription: discription ?? this.discription,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      customers: customers ?? this.customers,
      reviews: reviews ?? this.reviews,
      profilePic: profilePic ?? this.profilePic,
      showcaseImg: showcaseImg ?? this.showcaseImg,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'fullName': fullName});

    result.addAll({'personalAdress': personalAdress});
    result.addAll({'age': age});
    result.addAll({'profession': profession});
    result.addAll({'companyName': companyName});
    result.addAll({'companyAddress': companyAddress});
    result.addAll({'discription': discription});
    result.addAll({'email': email});
    result.addAll({'phoneNo': phoneNo});
    result.addAll({'customers': customers});
    result.addAll({'reviews': reviews});
    result.addAll({'profilePic': profilePic});
    result.addAll({'showcaseImg': showcaseImg});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] ?? '',
      personalAdress: map['personalAdress'] ?? '',
      age: map['age']?.toInt() ?? 0,
      uid: map['\$id'] ?? '',
      profession: List<String>.from(map['profession']),
      companyName: map['companyName'] ?? '',
      companyAddress: map['companyAddress'] ?? '',
      discription: map['discription'] ?? '',
      email: map['email'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      customers: List<String>.from(map['customers']),
      reviews: List<String>.from(map['reviews']),
      profilePic: map['profilePic'] ?? '',
      showcaseImg: List<String>.from(map['showcaseImg']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(fullName: $fullName,  personalAdress: $personalAdress, age: $age, uid: $uid, profession: $profession, companyName: $companyName, companyAddress: $companyAddress, discription: $discription, email: $email, phoneNo: $phoneNo, customers: $customers, reviews: $reviews, profilePic: $profilePic, showcaseImg: $showcaseImg)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.fullName == fullName &&
        other.personalAdress == personalAdress &&
        other.age == age &&
        other.uid == uid &&
        listEquals(other.profession, profession) &&
        other.companyName == companyName &&
        other.companyAddress == companyAddress &&
        other.discription == discription &&
        other.email == email &&
        other.phoneNo == phoneNo &&
        listEquals(other.customers, customers) &&
        listEquals(other.reviews, reviews) &&
        other.profilePic == profilePic &&
        listEquals(other.showcaseImg, showcaseImg);
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
        personalAdress.hashCode ^
        age.hashCode ^
        uid.hashCode ^
        profession.hashCode ^
        companyName.hashCode ^
        companyAddress.hashCode ^
        discription.hashCode ^
        email.hashCode ^
        phoneNo.hashCode ^
        customers.hashCode ^
        reviews.hashCode ^
        profilePic.hashCode ^
        showcaseImg.hashCode;
  }
}
