import "package:get/get.dart";
import '../model/review_model.dart';
import '../data/review_datasource.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/classes/base_request_controller.dart';

class DoctorReviewsController extends BaseRequestController {
  final ReviewDatasource _reviewDatasource = ReviewDatasource(
    crud: Get.find<AppServices>().crud,
  );
  List<ReviewModel> reviews = [];
  double averageRating = 0.0;
  int totalReviews = 0;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<void> fetchReviews(String doctorId) async {
    setStatus(RequestStatus.loading);

    final result = await _reviewDatasource.getDoctorReviews(doctorId);
    result.fold(
      (failure) {
        setStatus(failure.status);
      },
      (data) {
        reviews = data['reviews'] as List<ReviewModel>? ?? [];
        averageRating = data['average_rating'] as double? ?? 0.0;
        totalReviews = data['total_reviews'] as int? ?? 0;

        setStatus(
          reviews.isEmpty ? RequestStatus.noData : RequestStatus.success,
        );
      },
    );
    update();
  }
}
