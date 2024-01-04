import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_flow/presentation/utils/adaptive_cupertino.dart';
import 'package:social_flow/presentation/utils/adaptive_material.dart';
import 'package:social_flow/presentation/utils/gradient_circular_progress_indicator.dart';
import 'package:social_flow/theme/custom_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  pickImage({required BuildContext context, required ImageSource imageSource}) async {
    final ImagePicker imagePicker = ImagePicker();

    // Check and request camera permission
    if (imageSource == ImageSource.camera) {
      PermissionStatus cameraStatus = await Permission.camera.request();
      if (cameraStatus.isDenied) {
        if (context.mounted) {
          customSnackBar(context: context, content: "Camera permission is required to take a photo.");
        }
        return null;
      }
    }

    // Check and request storage permission
    PermissionStatus storageStatus = await Permission.storage.request();
    if (storageStatus.isDenied) {
      if (context.mounted) {
        customSnackBar(context: context, content: "Camera permission is required to take a photo.");
      }
      return null;
    }

    XFile? file = await imagePicker.pickImage(source: imageSource);
    if (file != null) {
      return file.readAsBytes();
    } else {
      if (context.mounted) {
        customSnackBar(context: context, content: "Didn't choose a image");
        return null;
      }
    }
  }

  customSnackBar({required BuildContext context, required String content}) {
    return Flushbar(
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      borderRadius: BorderRadius.circular(12),
      messageText: Container(
        alignment: Alignment.center,
        child: Text(
          content,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: const Duration(seconds: 3),
      backgroundGradient: const LinearGradient(
        colors: [
          CustomColors.firstGradientColor,
          CustomColors.secondGradientColor,
        ],
      ),
    ).show(context);
  }

  showAddPostBottomSheet({required BuildContext context}) {
    final bool ios = Theme.of(context).platform == TargetPlatform.iOS;
    return ios
        ? AdaptiveCupertino.openAddPostActionSheet(context: context)
        : AdaptiveMaterial.openAddPostBottomSheet(context: context);
  }

  Future<void> showDialogBox(
      {required BuildContext context, required Function() onTap, required String title, required String content}) {
    final bool ios = Theme.of(context).platform == TargetPlatform.iOS;
    return ios
        ? AdaptiveCupertino.openCupertinoDialog(context: context, onTap: onTap, title: title, content: content)
        : AdaptiveMaterial.openMaterialDialog(context: context, onTap: onTap, title: title, content: content);
  }

  Future<void> showAddProfileBottomSheet({required BuildContext context}) {
    final bool ios = Theme.of(context).platform == TargetPlatform.iOS;
    return ios
        ? AdaptiveCupertino.openAddProfileActionSheet(ctx: context)
        : AdaptiveMaterial.openAddProfileBottomSheet(ctx: context);
  }

  showDeletePostBottomSheet({required BuildContext context, required Function() onTap}) {
    final bool ios = Theme.of(context).platform == TargetPlatform.iOS;
    return ios
        ? AdaptiveCupertino.openDeletePostActionSheet(context: context, onTap: onTap)
        : AdaptiveMaterial.openDeletePostBottomSheet(context: context, onTap: onTap);
  }

  Widget containerShimmer({required double width, required double height, required BorderRadius borderRadius}) {
    return Shimmer.fromColors(
      baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
      highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: CustomColors.primaryLightColor.withOpacity(0.3),
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  Widget postCardImageShimmer({required double screenWidth, required double screenHeight}) {
    return Shimmer.fromColors(
      baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
      highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        margin: const EdgeInsets.only(top: 7),
        decoration: BoxDecoration(
          color: CustomColors.primaryLightColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2),
        ),
        child: const Center(
          child: GradientCircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget imageShimmer({required double screenHeight}) {
    return Shimmer.fromColors(
      baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
      highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
      child: Container(
        height: screenHeight,
        decoration: BoxDecoration(
          color: CustomColors.primaryLightColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: GradientCircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget profilePostShimmer() {
    return Shimmer.fromColors(
      baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
      highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.primaryLightColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget roundedPhotoShimmer({required double radius}) {
    return Shimmer.fromColors(
      baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
      highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.primaryLightColor.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget searchIdleShimmer({required double imageHeight}) {
    return Shimmer.fromColors(
      baseColor: CustomColors.firstGradientColor.withOpacity(0.8),
      highlightColor: CustomColors.secondGradientColor.withOpacity(0.6),
      child: Container(
        height: imageHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: CustomColors.primaryLightColor.withOpacity(0.3),
        ),
      ),
    );
  }

}
