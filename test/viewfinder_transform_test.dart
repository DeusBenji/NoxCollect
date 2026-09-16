import 'package:flutter_test/flutter_test.dart';
import 'package:noxcollect/features/scanner/utils/viewfinder_transform.dart';

void main() {
  group('ViewfinderTransform Math Tests', () {
    test('Portrait Image Taller than Screen (height cropped)', () {
      // Screen is 1080x2400 (aspect 9:20)
      // Image is 1080x1920 (aspect 9:16)
      // Because image is 9:16 and screen is 9:20, image is "wider" proportionally,
      // so BoxFit.cover makes image height 2400, and image width becomes 2400 * (9/16) = 1350.
      // OffsetX = (1350 - 1080) / 2 = 135
      //
      // If guide is left: 108, top: 240, width: 864, height: 1209.6
      final rect = ViewfinderTransform.mapScreenToImageCrop(
        screenWidth: 1080,
        screenHeight: 2400,
        imageWidth: 1080,
        imageHeight: 1920,
        guideLeft: 108,
        guideTop: 240,
        guideWidth: 864,
        guideHeight: 1209.6,
      );

      // Expected logic:
      // scaleX = imageWidth / scaledWidth = 1080 / 1350 = 0.8
      // scaleY = imageHeight / scaledHeight = 1920 / 2400 = 0.8
      // cropX = (108 + 135) * 0.8 = 243 * 0.8 = 194.4
      // cropY = (240 + 0) * 0.8 = 192
      // cropWidth = 864 * 0.8 = 691.2
      // cropHeight = 1209.6 * 0.8 = 967.68

      expect(rect.left, closeTo(194.4, 0.1));
      expect(rect.top, closeTo(192.0, 0.1));
      expect(rect.width, closeTo(691.2, 0.1));
      expect(rect.height, closeTo(967.68, 0.1));
    });

    test('Clamps to image bounds', () {
      final rect = ViewfinderTransform.mapScreenToImageCrop(
        screenWidth: 1000,
        screenHeight: 1000,
        imageWidth: 1000,
        imageHeight: 1000,
        guideLeft: -100, // Extends off screen
        guideTop: 0,
        guideWidth: 1500, // Way too wide
        guideHeight: 500,
      );

      expect(rect.left, 0.0);
      expect(rect.top, 0.0);
      expect(rect.width, 1000.0); // clamped to max image width
      expect(rect.height, 500.0);
    });
  });
}
