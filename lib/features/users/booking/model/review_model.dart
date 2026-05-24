class ReviewModel {
  final int id;
  final int rating;
  final String? comment;
  final String reviewerName;
  final String reviewedAt;
  final int? userId;
  final int? doctorId;
  final int? appointmentId;

  ReviewModel({
    required this.id,
    required this.rating,
    this.comment,
    required this.reviewerName,
    required this.reviewedAt,
    this.userId,
    this.doctorId,
    this.appointmentId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    // Handles both ReviewController@doctorReviews format
    // and appointment inline rating format
    final userMap = json['user'] as Map?;
    return ReviewModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment']?.toString() ?? json['review']?.toString(),
      reviewerName: userMap?['name']?.toString() ?? 'Anonymous',
      reviewedAt: json['reviewed_at']?.toString() ??
          json['created_at']?.toString() ??
          '',
      userId: (json['user_id'] as num?)?.toInt(),
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      appointmentId: (json['appointment_id'] as num?)?.toInt(),
    );
  }

  /// Returns a list of filled stars (1–5)
  List<bool> get starsList =>
      List.generate(5, (i) => i < rating);

  String get formattedDate {
    try {
      final dt = DateTime.parse(reviewedAt);
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return reviewedAt;
    }
  }
}
