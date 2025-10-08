class YouTubeHelper {
  static String? extractVideoId(String url) {
    try {
      final uri = Uri.parse(url);

      // Format 1: https://www.youtube.com/watch?v=VIDEO_ID
      if (uri.queryParameters.containsKey('v')) {
        return uri.queryParameters['v'];
      }

      // Format 2: https://youtu.be/VIDEO_ID
      if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
      }

      // Format 3: https://www.youtube.com/embed/VIDEO_ID
      if (uri.pathSegments.contains('embed') && uri.pathSegments.length > 1) {
        return uri.pathSegments[uri.pathSegments.indexOf('embed') + 1];
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// thumbnail
  static String getThumbnailUrl(
    String videoUrl, {
    ThumbnailQuality quality = ThumbnailQuality.high,
  }) {
    final videoId = extractVideoId(videoUrl);

    if (videoId == null || videoId.isEmpty) {
      return '';
    }

    return 'https://img.youtube.com/vi/$videoId/${quality.value}.jpg';
  }

  static Map<String, String> getAllThumbnails(String videoUrl) {
    final videoId = extractVideoId(videoUrl);

    if (videoId == null || videoId.isEmpty) {
      return {};
    }

    return {
      'maxres': 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg',
      'standard': 'https://img.youtube.com/vi/$videoId/sddefault.jpg',
      'high': 'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
      'medium': 'https://img.youtube.com/vi/$videoId/mqdefault.jpg',
      'default': 'https://img.youtube.com/vi/$videoId/default.jpg',
    };
  }
}


enum ThumbnailQuality {
  maxres('maxresdefault'), // 1920x1080
  standard('sddefault'), // 640x480
  high('hqdefault'), // 480x360
  medium('mqdefault'), // 320x180
  low('default'); // 120x90

  final String value;
  const ThumbnailQuality(this.value);
}
