import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_flow/presentation/utils/custom_size.dart';
import 'package:social_flow/theme/custom_colors.dart';

class ShimmerProfileheader extends StatelessWidget {
  const ShimmerProfileheader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
              highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
              child: CircleAvatar(
                radius: 46,
                backgroundColor: CustomColors.primaryLightColor.withOpacity(0.3),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: 8,
                    height: 24,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryLightColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                CustomSize.height5,
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: screenWidth / 8,
                    height: 10,
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: 8,
                    height: 24,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryLightColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                CustomSize.height5,
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: screenWidth / 8,
                    height: 10,
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: 8,
                    height: 24,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryLightColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                CustomSize.height5,
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: screenWidth / 8,
                    height: 10,
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
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: screenWidth / 3,
                    height: 10,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryLightColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                CustomSize.height10,
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: screenWidth / 2,
                    height: 10,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryLightColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                CustomSize.height10,
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: screenWidth / 3,
                    height: 10,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryLightColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                CustomSize.height10,
                Shimmer.fromColors(
                  baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
                  highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
                  child: Container(
                    width: screenWidth / 2,
                    height: 10,
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
            CustomSize.width10,
            Shimmer.fromColors(
              baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
              highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
              child: Container(
                width: screenWidth / 3,
                height: 34,
                decoration: BoxDecoration(
                  color: CustomColors.primaryLightColor.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
