import 'package:equatable/equatable.dart';

class OnBoardingModel extends Equatable {
  const OnBoardingModel({
    required this.title,
    required this.imgUrl,
    required this.description,
  });

  final String title, description, imgUrl;

  @override
  List<Object?> get props => [title, description, imgUrl];
}
