import 'package:flutter/material.dart';

final class AuthenticatedShell extends StatelessWidget {
  const AuthenticatedShell({
    required this.environment,
    required this.busy,
    required this.onSignOut,
    super.key,
  });

  final String environment;
  final bool busy;
  final Future<void> Function() onSignOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rajawali Operations'),
        actions: [
          IconButton(
            key: const Key('sign-out'),
            tooltip: 'Keluar',
            onPressed: busy ? null : onSignOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Operasional lapangan',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Sesi perangkat aman dan siap memakai API Rajawali yang sama.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.directions_car_outlined, size: 36),
                    const SizedBox(height: 16),
                    Text(
                      'Fleet workspace',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Pemilihan area kerja dan trip aktif menjadi vertical slice berikutnya.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Environment: $environment',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
