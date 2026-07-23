import 'package:flutter/material.dart';
import 'package:rajawali_mobile/bootstrap/app_bootstrap.dart';
import 'package:rajawali_mobile/core/config/app_config.dart';
import 'package:rajawali_mobile/features/auth/auth_screens.dart';
import 'package:rajawali_mobile/features/auth/mobile_auth_controller.dart';
import 'package:rajawali_mobile/features/fleet/fleet_repository.dart';
import 'package:rajawali_mobile/features/operations/operations_context_repository.dart';

class RajawaliMobileApp extends StatefulWidget {
  const RajawaliMobileApp({
    required this.config,
    required this.services,
    super.key,
  });

  final AppConfig config;
  final AppServices services;

  @override
  State<RajawaliMobileApp> createState() => _RajawaliMobileAppState();
}

final class _RajawaliMobileAppState extends State<RajawaliMobileApp> {
  late final MobileAuthController _authController;
  late final FleetRepository _fleetRepository;
  late final OperationsContextRepository _operationsRepository;

  @override
  void initState() {
    super.initState();
    _authController = MobileAuthController(widget.services.sessionManager);
    _operationsRepository = GeneratedOperationsContextRepository(
      widget.services.api,
    );
    _fleetRepository = GeneratedFleetRepository(widget.services.api);
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF173B57),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rajawali Operations',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
      ),
      home: MobileAuthFlow(
        controller: _authController,
        environment: widget.config.environment.label,
        fleetRepository: _fleetRepository,
        operationsRepository: _operationsRepository,
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
