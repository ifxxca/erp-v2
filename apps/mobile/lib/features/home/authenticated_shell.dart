import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rajawali_mobile/features/auth/mobile_auth_controller.dart';
import 'package:rajawali_mobile/features/operations/operations_context.dart';
import 'package:rajawali_mobile/features/operations/operations_context_controller.dart';
import 'package:rajawali_mobile/features/operations/operations_context_repository.dart';

final class AuthenticatedShell extends StatefulWidget {
  const AuthenticatedShell({
    required this.environment,
    required this.authController,
    required this.contextRepository,
    super.key,
  });

  final String environment;
  final MobileAuthController authController;
  final OperationsContextRepository contextRepository;

  @override
  State<AuthenticatedShell> createState() => _AuthenticatedShellState();
}

final class _AuthenticatedShellState extends State<AuthenticatedShell> {
  late final OperationsContextController _contextController;

  @override
  void initState() {
    super.initState();
    _contextController = OperationsContextController(
      widget.contextRepository,
      onSessionExpired: widget.authController.handleSessionExpired,
    );
    unawaited(_contextController.load());
  }

  @override
  void dispose() {
    _contextController.dispose();
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
      environment: widget.environment,
      onRefresh: _contextController.load,
      onSelectWorkspace: _showWorkspaceSelector,
      hasMultipleWorkspaces: _contextController.workspaces.length > 1,
    ),
  };

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
    required this.environment,
    required this.onRefresh,
    required this.onSelectWorkspace,
    required this.hasMultipleWorkspaces,
  });

  final OperatorIdentity identity;
  final OperationsWorkspace workspace;
  final String environment;
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
          Text(
            'Akses operasional',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _CapabilityCard(
            icon: Icons.directions_car_outlined,
            title: 'Fleet',
            enabled: capabilities.canViewVehicles,
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
            enabled: capabilities.canViewWorkOrders,
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
