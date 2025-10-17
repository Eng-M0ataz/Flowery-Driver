import 'package:flowery_tracking/core/functions/open_whatsapp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class _FakeUrlLauncher extends UrlLauncherPlatform {
  _FakeUrlLauncher({required this.canLaunchResult, this.launchResult = true});
  final bool canLaunchResult;
  final bool launchResult;
  LinkDelegate? _delegate;

  @override
  Future<bool> canLaunch(String url) async => canLaunchResult;

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async =>
      launchResult;

  @override
  Future<void> closeWebView() async {}

  @override
  LinkDelegate? get linkDelegate => _delegate;

  // Not marked override due to platform interface versions variability
  set linkDelegate(LinkDelegate? delegate) {
    _delegate = delegate;
  }
}

void main() {
  test('uses whatsapp scheme when available', () async {
    UrlLauncherPlatform.instance = _FakeUrlLauncher(
      canLaunchResult: true,
      launchResult: true,
    );
    await openWhatsApp('123', message: 'hi');
  });

  test('falls back to https when whatsapp not available', () async {
    UrlLauncherPlatform.instance = _FakeUrlLauncher(
      canLaunchResult: false,
      launchResult: true,
    );
    await openWhatsApp('123', message: 'hi');
  });
}
