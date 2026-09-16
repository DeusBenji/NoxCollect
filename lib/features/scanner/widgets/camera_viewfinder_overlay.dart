import 'package:flutter/material.dart';

/// Card-shaped viewfinder overlay with a 2.5:3.5 aspect ratio.
class CameraViewfinderOverlay extends StatelessWidget {
  final Widget child;

  const CameraViewfinderOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            // Standard Pokémon card aspect ratio is 2.5 x 3.5 = 1 : 1.4
            final targetWidth = screenWidth * 0.85;
            final targetHeight = targetWidth * 1.4;

            final left = (screenWidth - targetWidth) / 2;
            final top = (screenHeight - targetHeight) / 2.5;

            return Stack(
              children: [
                // Darkened background outside cutout
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.55),
                    BlendMode.srcOut,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                            left,
                            top,
                            left,
                            screenHeight - (top + targetHeight),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Card boundary guide frame
                Positioned(
                  left: left,
                  top: top,
                  width: targetWidth,
                  height: targetHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 2.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Top ROI hint (Card Name)
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Align Card Name',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        // Bottom ROI hint (Card Number)
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Align Card # (Bottom)',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
