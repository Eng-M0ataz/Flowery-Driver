import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProductItemShimmer extends StatelessWidget {
  const ProductItemShimmer({super.key});

  Widget _buildPlaceholder({
    double? height,
    double? width,
    bool isCircle = false,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle
            ? null
            : BorderRadius.circular(AppSizes.borderRadiusMd_8),
      ),
    );
  }

  Widget _buildSingleShimmerCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.borderRadiusXl_16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl_16),
      ),
      child:
          Row(
            children: [
              _buildPlaceholder(
                height: AppSizes.shimmerCircleSize_50,
                width: AppSizes.shimmerCircleSize_50,
                isCircle: true,
              ),
              const SizedBox(width: AppSizes.spaceBetweenItems_8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPlaceholder(
                      height: AppSizes.shimmerLineHeight_18,
                      width: AppSizes.shimmerLineWidth_150,
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_8),
                    _buildPlaceholder(
                      height: AppSizes.shimmerSmallLineHeight_14,
                    ),
                  ],
                ),
              ),
            ],
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildSingleShimmerCard(),
        ],
      ),
    );
  }
}
