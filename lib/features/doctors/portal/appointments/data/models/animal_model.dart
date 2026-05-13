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

  final String  id;
  final String  name;
  final String  species;
  final String  gender;
  final String  breed;
  final int     age;
  final double  weight;
  final String  ownerId;
  final String? imageUrl;

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id:       (json['id'] ?? 0).toString(),
      name:     json['name']    ?? '',
      species:  json['species'] ?? '',
      gender:   json['gender']  ?? '',
      breed:    json['breed']   ?? '',
      age:      json['age']     ?? 0,
      weight:   (json['weight'] ?? 0).toDouble(),
      ownerId:  (json['owner_id'] ?? 0).toString(),
      imageUrl: json['image_url'] ?? json['image_path'],
    );
  }

  Map<String, String> toFormFields() => {
    'name':    name,
    'species': species,
    'gender':  gender,
    'breed':   breed,
    'age':     age.toString(),
    'weight':  weight.toString(),
  };

  @override
  List<Object?> get props =>
      [id, name, species, gender, breed, age, weight, ownerId, imageUrl];
}
