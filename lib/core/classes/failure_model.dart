import 'package:equatable/equatable.dart';

import '../network/request_status.dart';

class FailureModel extends Equatable{
  final String message;
  final RequestStatus status;

  const FailureModel({
    required this.status,
    required this.message,
  });
  
  @override
  List<Object?> get props => [message, status];
}