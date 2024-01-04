import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_flow/theme/custom_colors.dart';

class ShimmerPostCardWidget extends StatelessWidget {
  const ShimmerPostCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomColors.primaryLightColor.withOpacity(0.3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Shimmer.fromColors(
                    baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                    highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.06,
                      decoration: BoxDecoration(
                        color: CustomColors.primaryLightColor.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
            highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
            child: Container(
              width: screenWidth,
              height: screenHeight / 2.1,
              margin: const EdgeInsets.only(top: 7),
              decoration: BoxDecoration(
                color: CustomColors.primaryLightColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
            highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
            child: Container(
              width: screenWidth * 0.6,
              height: screenWidth * 0.06,
              margin: const EdgeInsets.only(top: 10, left: 8),
              decoration: BoxDecoration(
                color: CustomColors.primaryLightColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
            highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
            child: Container(
              width: screenWidth * 0.6,
              height: screenWidth * 0.06,
              margin: const EdgeInsets.only(top: 10, left: 8),
              decoration: BoxDecoration(
                color: CustomColors.primaryLightColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
            highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
            child: Container(
              width: screenWidth * 0.45,
              height: screenWidth * 0.06,
              margin: const EdgeInsets.only(top: 10, left: 8),
              decoration: BoxDecoration(
                color: CustomColors.primaryLightColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
            highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
            child: Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.06,
              margin: const EdgeInsets.only(top: 10, left: 8),
              decoration: BoxDecoration(
                color: CustomColors.primaryLightColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
