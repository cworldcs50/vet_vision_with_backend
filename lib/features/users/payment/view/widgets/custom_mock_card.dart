import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomMockCard extends StatelessWidget {
  const CustomMockCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.credit_card,
                color: Colors.white,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 32,
                ),
              ),
              Text(
                "VISA",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 18,
                  ),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
          ),
          Text(
            "**** **** **** 3456",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CARD HOLDER",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Text(
                    "JOHN DOE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EXPIRES",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Text(
                    "12/28",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
