import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomSpecialOfferBanner extends StatelessWidget {
  const CustomSpecialOfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF009689).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        ),
        border: Border.all(
          color: const Color(0xFF009689).withValues(alpha: 0.3),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 10,
                    ),
                    vertical: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 4,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF009689),
                    borderRadius: BorderRadius.circular(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 8,
                      ),
                    ),
                  ),
                  child: Text(
                    "Special Offer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 10,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                ),
                Text(
                  "First consultation 20% off!",
                  style: TextStyle(
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 15,
                    ),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009689),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 15,
                      ),
                      vertical: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 8,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 12,
                      ),
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: -20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
              ),
              child: Image.asset(
                'assets/images/veterinary_dog.png', // Fallback or placeholder, adjust if this asset does not exist.
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 120,
                ),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 120,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.pets,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 40,
                      ),
                      color: Colors.grey.shade300,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
