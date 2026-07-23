import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rajawali_mobile/features/auth/mobile_auth_controller.dart';
import 'package:rajawali_mobile/features/fleet/fleet_controller.dart';
import 'package:rajawali_mobile/features/fleet/fleet_models.dart';
import 'package:rajawali_mobile/features/fleet/fleet_repository.dart';
import 'package:rajawali_mobile/features/fleet/trip_detail_screen.dart';
import 'package:rajawali_mobile/features/operations/operations_context.dart';
import 'package:rajawali_mobile/features/operations/operations_context_controller.dart';
import 'package:rajawali_mobile/features/operations/operations_context_repository.dart';

final class AuthenticatedShell extends StatefulWidget {
  const AuthenticatedShell({
    required this.environment,
    required this.authController,
    required this.contextRepository,
    required this.fleetRepository,
    super.key,
  });

  final String environment;
  final MobileAuthController authController;
  final OperationsContextRepository contextRepository;
  final FleetRepository fleetRepository;

  @override
  State<AuthenticatedShell> createState() => _AuthenticatedShellState();
}

final class _AuthenticatedShellState extends State<AuthenticatedShell> {
  late final OperationsContextController _contextController;
  late final FleetController _fleetController;

  @override
  void initState() {
    super.initState();
    _fleetController = FleetController(
      widget.fleetRepository,
      onSessionExpired: widget.authController.handleSessionExpired,
    );
    _contextController = OperationsContextController(
      widget.contextRepository,
      onSessionExpired: widget.authController.handleSessionExpired,
    );
    _contextController.addListener(_handleContextChanged);
    unawaited(_contextController.load());
  }

  @override
  void dispose() {
    _contextController.removeListener(_handleContextChanged);
    _contextController.dispose();
    _fleetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _contextController,
      builder: (context, _) {
        final active = _contextController.activeWorkspace;
        return Scaffold(
          appBar: AppBar(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rajawali Operations'),
                Text(
                  'Fleet & Maintenance',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            actions: [
              if (_contextController.stage == OperationsContextStage.ready &&
                  active != null)
                IconButton(
                  key: const Key('context-selector'),
                  tooltip: 'Pilih area kerja',
                  onPressed: _showWorkspaceSelector,
                  icon: const Icon(Icons.location_on_outlined),
                ),
              IconButton(
                key: const Key('sign-out'),
                tooltip: 'Keluar',
                onPressed: widget.authController.busy
                    ? null
                    : widget.authController.signOut,
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: SafeArea(child: _body()),
        );
      },
    );
  }

  Widget _body() => switch (_contextController.stage) {
    OperationsContextStage.loading => const _LoadingContext(),
    OperationsContextStage.failure => _ContextFailure(
      message:
          _contextController.failure?.message ??
          'Area kerja tidak dapat disiapkan.',
      requestId: _contextController.failure?.requestId,
      onRetry: _contextController.load,
    ),
    OperationsContextStage.empty => _EmptyContext(
      identity: _contextController.identity,
    ),
    OperationsContextStage.ready => _WorkspaceOverview(
      identity: _contextController.identity!,
      workspace: _contextController.activeWorkspace!,
      fleetController: _fleetController,
      environment: widget.environment,
      onOpenTrip: _openTrip,
      onRefresh: _refreshAll,
      onSelectWorkspace: _showWorkspaceSelector,
      hasMultipleWorkspaces: _contextController.workspaces.length > 1,
    ),
  };

  void _handleContextChanged() {
    if (_contextController.stage != OperationsContextStage.ready) return;
    final active = _contextController.activeWorkspace;
    if (active != null && _fleetController.workspace?.key != active.key) {
      unawaited(_fleetController.load(active));
    }
  }

  Future<void> _refreshAll() async {
    await _contextController.load();
    if (_contextController.stage != OperationsContextStage.ready) return;
    final active = _contextController.activeWorkspace;
    if (active != null && _fleetController.stage != FleetStage.loading) {
      await _fleetController.load(active);
    }
  }

  Future<void> _openTrip(FleetTrip trip) async {
    final workspace = _contextController.activeWorkspace;
    if (workspace == null) return;
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => TripDetailScreen(
          scope: FleetScope.fromWorkspace(workspace),
          tripId: trip.id,
          repository: widget.fleetRepository,
          onSessionExpired: widget.authController.handleSessionExpired,
        ),
      ),
    );
  }

  Future<void> _showWorkspaceSelector() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Text(
                  'Pilih area kerja',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              for (final workspace in _contextController.workspaces)
                ListTile(
                  key: Key('workspace-${workspace.key}'),
                  leading: const Icon(Icons.warehouse_outlined),
                  title: Text(workspace.location.name),
                  subtitle: Text(
                    '${workspace.company.code} · ${workspace.company.legalName}',
                  ),
                  trailing:
                      workspace.key == _contextController.activeWorkspace?.key
                      ? const Icon(Icons.check_circle)
                      : null,
                  onTap: () => Navigator.pop(context, workspace.key),
                ),
            ],
          ),
        ),
      ),
    );
    if (selected != null) _contextController.select(selected);
  }
}

final class _LoadingContext extends StatelessWidget {
  const _LoadingContext();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 18),
          Text('Menyiapkan area operasional…'),
        ],
      ),
    );
  }
}

final class _ContextFailure extends StatelessWidget {
  const _ContextFailure({
    required this.message,
    required this.requestId,
    required this.onRetry,
  });

  final String message;
  final String? requestId;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            children: [
              const Icon(Icons.cloud_off_outlined, size: 56),
              const SizedBox(height: 20),
              Text(
                'Area kerja belum dapat dimuat',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              if (requestId case final id?) ...[
                const SizedBox(height: 6),
                Text(
                  'Referensi: $id',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                key: const Key('context-retry'),
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _EmptyContext extends StatelessWidget {
  const _EmptyContext({required this.identity});

  final OperatorIdentity? identity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            children: [
              const Icon(Icons.domain_disabled_outlined, size: 56),
              const SizedBox(height: 20),
              Text(
                'Belum ada area kerja',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                '${identity?.name ?? 'Akun ini'} belum memiliki akses Fleet, Trip, atau Maintenance pada lokasi aktif.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Hubungi administrator untuk memeriksa membership dan role.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _WorkspaceOverview extends StatelessWidget {
  const _WorkspaceOverview({
    required this.identity,
    required this.workspace,
    required this.fleetController,
    required this.environment,
    required this.onOpenTrip,
    required this.onRefresh,
    required this.onSelectWorkspace,
    required this.hasMultipleWorkspaces,
  });

  final OperatorIdentity identity;
  final OperationsWorkspace workspace;
  final FleetController fleetController;
  final String environment;
  final Future<void> Function(FleetTrip trip) onOpenTrip;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onSelectWorkspace;
  final bool hasMultipleWorkspaces;

  @override
  Widget build(BuildContext context) {
    final capabilities = workspace.capabilities;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        key: const Key('operations-workspace'),
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          _IdentityCard(identity: identity),
          const SizedBox(height: 24),
          Text(
            workspace.company.legalName,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(
            workspace.location.name,
            key: const Key('active-location'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '${workspace.location.code} · ${workspace.location.timezone}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (hasMultipleWorkspaces) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onSelectWorkspace,
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Ganti area kerja'),
            ),
          ],
          const SizedBox(height: 28),
          _FleetDashboard(controller: fleetController, onOpenTrip: onOpenTrip),
          const SizedBox(height: 28),
          Text(
            'Hak akses pada area ini',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _CapabilityCard(
            icon: Icons.directions_car_outlined,
            title: 'Fleet',
            enabled:
                capabilities.canViewVehicles || capabilities.canManageVehicles,
            action: capabilities.canManageVehicles
                ? 'Lihat dan kelola kendaraan'
                : 'Lihat kendaraan',
          ),
          const SizedBox(height: 10),
          _CapabilityCard(
            icon: Icons.route_outlined,
            title: 'Trip',
            enabled: capabilities.canViewTrips || capabilities.canOperateTrips,
            action: _tripAccess(capabilities),
          ),
          const SizedBox(height: 10),
          _CapabilityCard(
            icon: Icons.build_outlined,
            title: 'Maintenance',
            enabled:
                capabilities.canViewWorkOrders ||
                capabilities.canManageWorkOrders,
            action: capabilities.canManageWorkOrders
                ? 'Lihat dan kelola work order'
                : 'Lihat work order',
          ),
          const SizedBox(height: 24),
          Text(
            'Environment: $environment',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  static String _tripAccess(MobileOperationsCapabilities capabilities) {
    if (capabilities.canManageTrips) return 'Lihat dan kelola seluruh trip';
    if (capabilities.canOperateTrips) {
      return 'Checkout dan check-in trip sendiri';
    }
    return 'Lihat trip';
  }
}

final class _FleetDashboard extends StatelessWidget {
  const _FleetDashboard({required this.controller, required this.onOpenTrip});

  final FleetController controller;
  final Future<void> Function(FleetTrip trip) onOpenTrip;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => switch (controller.stage) {
        FleetStage.idle || FleetStage.loading => const Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 16),
                Expanded(child: Text('Memuat data Fleet…')),
              ],
            ),
          ),
        ),
        FleetStage.failure => _FleetFailure(controller: controller),
        FleetStage.ready => _FleetContent(
          controller: controller,
          onOpenTrip: onOpenTrip,
        ),
      },
    );
  }
}

final class _FleetFailure extends StatelessWidget {
  const _FleetFailure({required this.controller});

  final FleetController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Data Fleet belum dapat dimuat',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              controller.failure?.message ??
                  'Terjadi kesalahan ketika menyiapkan data.',
            ),
            if (controller.failure?.requestId case final id?) ...[
              const SizedBox(height: 4),
              Text(
                'Referensi: $id',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton.icon(
              key: const Key('fleet-retry'),
              onPressed: controller.workspace == null
                  ? null
                  : () => controller.load(controller.workspace!),
              icon: const Icon(Icons.refresh),
              label: const Text('Muat ulang Fleet'),
            ),
          ],
        ),
      ),
    );
  }
}

final class _FleetContent extends StatelessWidget {
  const _FleetContent({required this.controller, required this.onOpenTrip});

  final FleetController controller;
  final Future<void> Function(FleetTrip trip) onOpenTrip;

  @override
  Widget build(BuildContext context) {
    final workspace = controller.workspace!;
    final capabilities = workspace.capabilities;
    final canSeeVehicles =
        capabilities.canViewVehicles || capabilities.canManageVehicles;
    final canSeeTrips =
        capabilities.canViewTrips ||
        capabilities.canOperateTrips ||
        capabilities.canManageTrips;

    if (!canSeeVehicles && !canSeeTrips) {
      return const Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Area ini hanya memiliki akses Maintenance. Data Fleet dan Trip tidak dimuat.',
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Ringkasan Fleet', style: Theme.of(context).textTheme.titleLarge),
        if (canSeeVehicles) ...[
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _FleetMetric(
                label: 'Total',
                value: controller.vehicles.total,
                icon: Icons.directions_car_outlined,
              ),
              _FleetMetric(
                label: 'Tersedia',
                value: controller.statusCounts.available,
                icon: Icons.check_circle_outline,
              ),
              _FleetMetric(
                label: 'Digunakan',
                value: controller.statusCounts.inUse,
                icon: Icons.route_outlined,
              ),
              _FleetMetric(
                label: 'Maintenance',
                value: controller.statusCounts.maintenance,
                icon: Icons.build_outlined,
              ),
            ],
          ),
        ],
        if (canSeeTrips) ...[
          const SizedBox(height: 28),
          _SectionTitle(
            title: 'Trip aktif',
            count: controller.activeTrips.total,
          ),
          const SizedBox(height: 10),
          if (controller.activeTrips.data.isEmpty)
            const _FleetEmpty(message: 'Tidak ada trip aktif pada area ini.')
          else
            for (final trip in controller.activeTrips.data) ...[
              _TripCard(trip: trip, onTap: () => onOpenTrip(trip)),
              const SizedBox(height: 10),
            ],
          if (controller.activeTrips.hasMore)
            OutlinedButton(
              key: const Key('load-more-trips'),
              onPressed: controller.loadingMoreTrips
                  ? null
                  : controller.loadMoreTrips,
              child: Text(
                controller.loadingMoreTrips
                    ? 'Memuat…'
                    : 'Muat trip berikutnya',
              ),
            ),
        ],
        if (canSeeVehicles) ...[
          const SizedBox(height: 28),
          _SectionTitle(title: 'Kendaraan', count: controller.vehicles.total),
          const SizedBox(height: 10),
          if (controller.vehicles.data.isEmpty)
            const _FleetEmpty(message: 'Belum ada kendaraan pada area ini.')
          else
            for (final vehicle in controller.vehicles.data) ...[
              _VehicleCard(vehicle: vehicle),
              const SizedBox(height: 10),
            ],
          if (controller.vehicles.hasMore)
            OutlinedButton(
              key: const Key('load-more-vehicles'),
              onPressed: controller.loadingMoreVehicles
                  ? null
                  : controller.loadMoreVehicles,
              child: Text(
                controller.loadingMoreVehicles
                    ? 'Memuat…'
                    : 'Muat kendaraan berikutnya',
              ),
            ),
        ],
        if (controller.paginationError case final message?) ...[
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }
}

final class _FleetMetric extends StatelessWidget {
  const _FleetMetric({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final int value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$value', style: Theme.of(context).textTheme.titleLarge),
                  Text(label, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        Badge(label: Text('$count')),
      ],
    );
  }
}

final class _FleetEmpty extends StatelessWidget {
  const _FleetEmpty({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}

final class _TripCard extends StatelessWidget {
  const _TripCard({required this.trip, required this.onTap});

  final FleetTrip trip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('trip-${trip.id}'),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      trip.vehiclePlateNumber,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const _StatusPill(label: 'Aktif', color: Colors.blue),
                  const SizedBox(width: 6),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 8),
              Text(trip.purpose),
              if (trip.destination case final destination?)
                Text(
                  'Tujuan: $destination',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              const SizedBox(height: 8),
              Text(
                '${trip.driverName} · berangkat ${_formatDateTime(trip.departedAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _VehicleCard extends StatelessWidget {
  const _VehicleCard({required this.vehicle});

  final FleetVehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final status = _vehicleStatusPresentation(vehicle.status);
    return Card(
      key: Key('vehicle-${vehicle.id}'),
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.directions_car_outlined)),
        title: Text(vehicle.plateNumber),
        subtitle: Text(
          '${vehicle.brand} ${vehicle.model} · ${vehicle.currentOdometer} km',
        ),
        trailing: _StatusPill(label: status.$1, color: status.$2),
      ),
    );
  }
}

final class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
        ),
      ),
    );
  }
}

(String, Color) _vehicleStatusPresentation(FleetVehicleStatus status) {
  return switch (status) {
    FleetVehicleStatus.available => ('Tersedia', Colors.green),
    FleetVehicleStatus.inUse => ('Digunakan', Colors.blue),
    FleetVehicleStatus.maintenance => ('Maintenance', Colors.orange),
    FleetVehicleStatus.blocked => ('Diblokir', Colors.red),
    FleetVehicleStatus.inactive => ('Nonaktif', Colors.grey),
    FleetVehicleStatus.unknown => ('Tidak dikenal', Colors.grey),
  };
}

String _formatDateTime(DateTime value) {
  final local = value.toLocal();
  String two(int number) => number.toString().padLeft(2, '0');
  return '${two(local.day)}/${two(local.month)}/${local.year} ${two(local.hour)}:${two(local.minute)}';
}

final class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.identity});

  final OperatorIdentity identity;

  @override
  Widget build(BuildContext context) {
    final initial = identity.name.trim().isEmpty
        ? '?'
        : identity.name.trim().substring(0, 1).toUpperCase();
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: CircleAvatar(child: Text(initial)),
        title: Text(identity.name, key: const Key('operator-name')),
        subtitle: Text(identity.email),
        trailing: const Icon(Icons.verified_user_outlined),
      ),
    );
  }
}

final class _CapabilityCard extends StatelessWidget {
  const _CapabilityCard({
    required this.icon,
    required this.title,
    required this.enabled,
    required this.action,
  });

  final IconData icon;
  final String title;
  final bool enabled;
  final String action;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      color: enabled ? null : colors.surfaceContainerLow,
      child: ListTile(
        enabled: enabled,
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(enabled ? action : 'Tidak tersedia pada area ini'),
        trailing: Icon(enabled ? Icons.chevron_right : Icons.lock_outline),
      ),
    );
  }
}
