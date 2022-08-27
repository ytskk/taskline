import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Task Line',
                style: theme.textTheme.titleLarge,
              ),
              FutureBuilder<String>(
                future: _getVersion(),
                builder: (context, snapshot) {
                  log('snapshot.data: ${snapshot.data}');

                  return Text(
                    'Version ${snapshot.data}',
                    style: theme.textTheme.bodySmall,
                  );
                },
              ),
              TextButton(
                onPressed: () async {
                  await _openGitHubRepo();
                },
                child: Text('Open GitHub Repo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }

  Future _openGitHubRepo() async {
    final url = Uri.parse('https://github.com/ytskk/taskline');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
