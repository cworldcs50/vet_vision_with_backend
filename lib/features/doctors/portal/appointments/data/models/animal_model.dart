import 'dart:developer';

import 'package:equatable/equatable.dart';

/// Matches Laravel's AnimalResource / Animal model response.
class AnimalModel extends Equatable {
  const AnimalModel({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.breed,
    required this.age,
    required this.weight,
    required this.ownerId,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String species;
  final String gender;
  final String breed;
  final int age;
  final double weight;
  final String ownerId;
  final String? imageUrl;

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    log(json['image_url']);
    return AnimalModel(
      age: json['age'] ?? 0,
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
      gender: json['gender'] ?? '',
      species: json['species'] ?? '',
      id: (json['id'] ?? 0).toString(),
      //http://localhost/VetVision-API/VetVision-API/public/storage/animals/...
      imageUrl: json['image_url'] != null
          ? "http://10.0.2.2/VetVision-API/VetVision-API/storage/app/public/animals/${json['image_url'].toString().split("/").last}"
          : null,
      weight: (json['weight'] ?? 0).toDouble(),
      ownerId: (json['owner_id'] ?? 0).toString(),
    );
  }

  Map<String, String> toFormFields() => {
    'name': name,
    'breed': breed,
    'gender': gender,
    'species': species,
    'age': age.toString(),
    'weight': weight.toString(),
  };

  @override
  List<Object?> get props => [
    id,
    name,
    species,
    gender,
    breed,
    age,
    weight,
    ownerId,
    imageUrl,
  ];
}
