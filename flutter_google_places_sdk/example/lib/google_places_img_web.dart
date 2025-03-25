import 'dart:ui_web';
import 'package:web/web.dart' as web;

import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

/// Widget used to display google place image. Used in web platforms
class GooglePlacesImg extends StatelessWidget {
  /// The photo metadata
  final PhotoMetadata photoMetadata;

  /// The photo fetch response
  final FetchPlacePhotoResponse placePhotoResponse;

  /// Construct a google place img using metadata and response object
  const GooglePlacesImg({Key? key, required this.photoMetadata, required this.placePhotoResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = switch (placePhotoResponse) {
      FetchPlacePhotoResponseImageUrl(:final imageUrl) => imageUrl,
      _ => null,
    };

    if (imageUrl == null) return Text('Invalid image');

    // ignore: undefined_prefixed_name
    platformViewRegistry.registerViewFactory(
      photoMetadata.photoReference,
      (int viewId) => web.HTMLImageElement()
        ..id = 'gp_img_$viewId'
        ..setAttribute('src', imageUrl),
    );

    final view = HtmlElementView(viewType: photoMetadata.photoReference);
    return Container(
      width: photoMetadata.width.toDouble(),
      height: photoMetadata.height.toDouble(),
      child: view,
    );
  }
}
