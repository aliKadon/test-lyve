import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/preferences/shared_pref_controller.dart';
import '../resources/values_manager.dart';

class SliderBanner extends StatefulWidget {
  List<dynamic>? images;

  SliderBanner({this.images});

  @override
  State<SliderBanner> createState() => _SliderBannerState();
}

class _SliderBannerState extends State<SliderBanner> {
  var isLoop = false;

  @override
  Widget build(BuildContext context) {
    if(widget.images?.length == 1) {
      isLoop = false;
    }else {
      isLoop = true;
    }
    return SizedBox(
      height: 150.h,
      width: 200.w,
      child: ImageSlideshow(
          isLoop: isLoop,
          autoPlayInterval: 4000,
          children: List<Widget>.generate(
            widget.images?.length ?? 0,
            (index) => Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s15)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    "${widget.images?[index]}",
                    fit: BoxFit.scaleDown,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error_outline);
                    },
                  )),
            ),
          )),
    );
  }
}
