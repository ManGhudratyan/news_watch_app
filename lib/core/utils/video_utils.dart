class VideoUtils {
  static String? getYoutubeThumbnail(String? url) {
    if (url == null || url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    String? videoId;

    if (uri.host.contains('youtube.com')) {
      videoId = uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be')) {
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    if (videoId == null || videoId.isEmpty) return null;

    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }
}
