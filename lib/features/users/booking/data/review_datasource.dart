import 'package:dartz/dartz.dart';
import '../../../../../core/classes/crud.dart';
import '../../../../../core/classes/failure_model.dart';
import '../../../../../core/constants/link_api.dart';
import '../../../../../core/network/request_status.dart';
import '../model/review_model.dart';

class ReviewDatasource {
  const ReviewDatasource({required this.crud});
  final Crud crud;

  // ── GET /doctors/{id}/reviews ─────────────────────────────────────────────
  Future<Either<FailureModel, Map<String, dynamic>>> getDoctorReviews(
    String doctorId,
  ) async {
    final result = await crud.get(AppLink.doctorReviewsList(doctorId));
    return result.fold(Left.new, (json) {
      try {
        final data = json['data'] as Map<String, dynamic>? ?? {};
        return Right({
          'average_rating': (data['average_rating'] as num?)?.toDouble() ?? 0.0,
          'total_reviews': (data['total_reviews'] as num?)?.toInt() ?? 0,
          'reviews': (data['reviews'] as List? ?? [])
              .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        });
      } catch (e) {
        return Left(FailureModel(
          status: RequestStatus.failure,
          message: e.toString(),
        ));
      }
    });
  }

  // ── POST /appointments/{id}/rate ──────────────────────────────────────────
  Future<Either<FailureModel, bool>> submitReview(
    String appointmentId,
    int rating, {
    String? comment,
  }) async {
    final body = <String, String>{'rating': rating.toString()};
    if (comment != null && comment.isNotEmpty) body['comment'] = comment;

    final result = await crud.post(AppLink.storeReview(appointmentId), body);
    if (result['request_status'] == RequestStatus.success && result['status'] == true) {
      return const Right(true);
    }
    return Left(FailureModel(
      status: result['request_status'] ?? RequestStatus.failure,
      message: result['message']?.toString() ?? 'Failed to submit review',
    ));
  }

  // ── PUT /reviews/{id} ─────────────────────────────────────────────────────
  Future<Either<FailureModel, bool>> updateReview(
    String reviewId,
    int rating, {
    String? comment,
  }) async {
    final body = <String, String>{'rating': rating.toString()};
    if (comment != null && comment.isNotEmpty) body['comment'] = comment;

    final result = await crud.put(AppLink.review(reviewId), body);
    if (result['request_status'] == RequestStatus.success && result['status'] == true) {
      return const Right(true);
    }
    return Left(FailureModel(
      status: result['request_status'] ?? RequestStatus.failure,
      message: result['message']?.toString() ?? 'Failed to update review',
    ));
  }

  // ── DELETE /reviews/{id} ──────────────────────────────────────────────────
  Future<Either<FailureModel, bool>> deleteReview(String reviewId) async {
    final result = await crud.delete(AppLink.review(reviewId));
    if (result['request_status'] == RequestStatus.success && result['status'] == true) {
      return const Right(true);
    }
    return Left(FailureModel(
      status: result['request_status'] ?? RequestStatus.failure,
      message: result['message']?.toString() ?? 'Failed to delete review',
    ));
  }
}
