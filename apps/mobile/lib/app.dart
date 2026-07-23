import 'package:flutter/material.dart';
import 'package:rajawali_mobile/bootstrap/app_bootstrap.dart';
import 'package:rajawali_mobile/core/config/app_config.dart';

class RajawaliMobileApp extends StatelessWidget {
  const RajawaliMobileApp({
    required this.config,
    required this.services,
    super.key,
  });

  final AppConfig config;
  final AppServices services;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rajawali Operations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF173B57)),
        useMaterial3: true,
      ),
      home: MobileFoundationScreen(
        environment: config.environment.label,
        hasRestoredSession: services.sessionManager.hasSession,
      ),
    );
  }
}

class MobileFoundationScreen extends StatelessWidget {
  const MobileFoundationScreen({
    required this.environment,
    required this.hasRestoredSession,
    super.key,
  });

  final String environment;
  final bool hasRestoredSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rajawali Operations')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Mobile foundation ready',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Environment: $environment',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasRestoredSession
                        ? 'Secure session ditemukan.'
                        : 'Belum ada secure session.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BootstrapFailureApp extends StatelessWidget {
  const BootstrapFailureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Konfigurasi aplikasi tidak valid. Hubungi administrator.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
