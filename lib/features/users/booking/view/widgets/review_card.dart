import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../model/review_model.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
      ),
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 10,
            ),
            offset: Offset(
              0,
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 5),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 20,
                ),
                backgroundColor: const Color(0xFF009689).withValues(alpha: 0.2),
                child: Text(
                  review.reviewerName.isNotEmpty
                      ? review.reviewerName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: const Color(0xFF009689),
                    fontWeight: FontWeight.bold,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 10,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      review.formattedDate,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: review.starsList
                    .map(
                      (isFilled) => Icon(
                        isFilled ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 10,
              ),
            ),
            Text(
              review.comment!,
              style: TextStyle(
                color: Colors.black87,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
