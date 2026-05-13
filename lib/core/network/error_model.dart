import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  const ErrorModel({required this.title, required this.message});

  final String title, message;

  @override
  List<Object?> get props => [title, message];
}
