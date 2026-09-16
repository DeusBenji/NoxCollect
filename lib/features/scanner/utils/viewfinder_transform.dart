import 'dart:math';
import 'dart:ui';

/// Helper to map the visual CameraViewfinderOverlay bounds to the actual captured image pixels.
class ViewfinderTransform {
  /// Maps a visual screen rectangle to a crop rectangle on the captured image.
  ///
  /// Account for:
  /// - `previewSize`: The size of the screen or CameraPreview widget
  /// - `imageSize`: The pixel dimensions of the captured image (handling orientation)
  /// - `guideRect`: The bounding box of the yellow guide in screen coordinates
  ///
  /// Returns a Rect representing the crop coordinates in the original image.
  static Rect mapScreenToImageCrop({
    required double screenWidth,
    required double screenHeight,
    required double imageWidth,
    required double imageHeight,
    required double guideLeft,
    required double guideTop,
    required double guideWidth,
    required double guideHeight,
  }) {
    // 1. Determine the scaled size of the image when fit with BoxFit.cover
    final double screenAspect = screenWidth / screenHeight;
    final double imageAspect = imageWidth / imageHeight;

    double scaledImageWidth;
    double scaledImageHeight;
    double offsetX = 0.0;
    double offsetY = 0.0;

    if (imageAspect > screenAspect) {
      // Image is wider than the screen. Height fits perfectly, width is cropped.
      scaledImageHeight = screenHeight;
      scaledImageWidth = screenHeight * imageAspect;
      offsetX = (scaledImageWidth - screenWidth) / 2;
    } else {
      // Image is taller than the screen. Width fits perfectly, height is cropped.
      scaledImageWidth = screenWidth;
      scaledImageHeight = screenWidth / imageAspect;
      offsetY = (scaledImageHeight - screenHeight) / 2;
    }

    // 2. Map screen guide coordinates to the scaled image space
    final double guideInScaledX = guideLeft + offsetX;
    final double guideInScaledY = guideTop + offsetY;

    // 3. Map scaled image coordinates to actual image pixels
    final double scaleFactorX = imageWidth / scaledImageWidth;
    final double scaleFactorY = imageHeight / scaledImageHeight;

    final double cropX = guideInScaledX * scaleFactorX;
    final double cropY = guideInScaledY * scaleFactorY;
    final double cropWidth = guideWidth * scaleFactorX;
    final double cropHeight = guideHeight * scaleFactorY;

    // 4. Clamp the output to strictly stay inside the image bounds
    final double clampedX = max(0.0, cropX);
    final double clampedY = max(0.0, cropY);
    final double clampedWidth = min(cropWidth, imageWidth - clampedX);
    final double clampedHeight = min(cropHeight, imageHeight - clampedY);

    return Rect.fromLTWH(clampedX, clampedY, clampedWidth, clampedHeight);
  }
}
