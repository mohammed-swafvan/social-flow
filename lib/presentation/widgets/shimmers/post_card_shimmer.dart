import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostCardWidget extends StatelessWidget {
  const ShimmerPostCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                  baseColor: Colors.grey[500]!,
                  highlightColor: Colors.grey[300]!,
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[500]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.06,
                      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.4,
              margin: const EdgeInsets.only(top: 7),
              decoration: const BoxDecoration(color: Colors.grey),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: screenWidth * 0.6,
              height: screenWidth * 0.06,
              margin: const EdgeInsets.only(top: 10, left: 8),
              decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: screenWidth * 0.6,
              height: screenWidth * 0.06,
              margin: const EdgeInsets.only(top: 10, left: 8),
              decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: screenWidth * 0.45,
              height: screenWidth * 0.06,
              margin: const EdgeInsets.only(top: 10, left: 8),
              decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.06,
              margin: const EdgeInsets.only(top: 10, left: 8),
              decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ],
      ),
    );
  }
}
