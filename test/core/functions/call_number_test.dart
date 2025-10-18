import 'package:flowery_tracking/core/functions/call_number.dart';
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
  test('calls platform launch when canLaunch is true', () async {
    UrlLauncherPlatform.instance = _FakeUrlLauncher(
      canLaunchResult: true,
      launchResult: true,
    );
    await callNumber('123');
  });

  test('throws when cannot launch', () async {
    UrlLauncherPlatform.instance = _FakeUrlLauncher(canLaunchResult: false);
    expect(() => callNumber('123'), throwsA(isA<String>()));
  });
}
