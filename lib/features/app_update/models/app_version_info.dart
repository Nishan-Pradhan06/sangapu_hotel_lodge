class AppVersionInfo {
  final String latestVersion;
  final int latestBuildNumber;
  final String minSupportedVersion;
  final int minSupportedBuildNumber;
  final bool forceUpdate;
  final String title;
  final String releaseNotes;
  final String playStoreUrl;
  final String? directDownloadUrl;

  const AppVersionInfo({
    required this.latestVersion,
    required this.latestBuildNumber,
    required this.minSupportedVersion,
    required this.minSupportedBuildNumber,
    required this.forceUpdate,
    required this.title,
    required this.releaseNotes,
    required this.playStoreUrl,
    this.directDownloadUrl,
  });

  factory AppVersionInfo.fromJson(Map<String, dynamic> json) {
    return AppVersionInfo(
      latestVersion: json['latest_version'] as String? ?? '1.0.0',
      latestBuildNumber: (json['latest_build_number'] as num?)?.toInt() ?? 1,
      minSupportedVersion: json['min_supported_version'] as String? ?? '1.0.0',
      minSupportedBuildNumber:
          (json['min_supported_build_number'] as num?)?.toInt() ?? 1,
      forceUpdate: json['force_update'] as bool? ?? false,
      title: json['title'] as String? ?? 'New Update Available!',
      releaseNotes: json['release_notes'] as String? ??
          'A new version of Sangapu is available with performance improvements and bug fixes.',
      playStoreUrl: json['play_store_url'] as String? ??
          'https://play.google.com/store/apps/details?id=com.nishan.sangapu',
      directDownloadUrl: json['direct_download_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latest_version': latestVersion,
      'latest_build_number': latestBuildNumber,
      'min_supported_version': minSupportedVersion,
      'min_supported_build_number': minSupportedBuildNumber,
      'force_update': forceUpdate,
      'title': title,
      'release_notes': releaseNotes,
      'play_store_url': playStoreUrl,
      'direct_download_url': directDownloadUrl,
    };
  }
}
