import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/shared/assets.dart';

class NewsfeedLoading extends StatelessWidget {
  const NewsfeedLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _loadingNewsfeed(),
        _loadingNewsfeed(),
        _loadingNewsfeed(),
      ],
    );
  }

  Widget _loadingNewsfeed({
    double width = 375,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          color: Colors.white,
                          height: 32.w,
                          width: 32.w
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20.w,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SvgPicture.asset(Assets.moreOption)
              ],
            ),
          ),
          Container(
            height: width,
            width: width,
            color: Colors.white,
          ),
          const SizedBox(height: 8,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20.w,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4,),
                Container(
                  height: 20.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4,),
              ],
            ),
          )
        ],
      ),
    );
  }
}