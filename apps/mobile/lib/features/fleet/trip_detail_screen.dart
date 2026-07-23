import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rajawali_mobile/features/fleet/fleet_models.dart';
import 'package:rajawali_mobile/features/fleet/fleet_repository.dart';
import 'package:rajawali_mobile/features/fleet/trip_detail_controller.dart';

final class TripDetailScreen extends StatefulWidget {
  const TripDetailScreen({
    required this.scope,
    required this.tripId,
    required this.repository,
    required this.onSessionExpired,
    super.key,
  });

  final FleetScope scope;
  final String tripId;
  final FleetRepository repository;
  final Future<void> Function() onSessionExpired;

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

final class _TripDetailScreenState extends State<TripDetailScreen> {
  late final TripDetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TripDetailController(
      widget.repository,
      onSessionExpired: _handleSessionExpired,
    );
    unawaited(_controller.load(widget.scope, widget.tripId));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail trip')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => switch (_controller.stage) {
            TripDetailStage.loading => const _TripDetailLoading(),
            TripDetailStage.failure => _TripDetailFailure(
              controller: _controller,
            ),
            TripDetailStage.ready => _TripDetailContent(
              trip: _controller.trip!,
              onRefresh: _controller.retry,
            ),
          },
        ),
      ),
    );
  }

  Future<void> _handleSessionExpired() async {
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    await widget.onSessionExpired();
  }
}

final class _TripDetailLoading extends StatelessWidget {
  const _TripDetailLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat detail trip…'),
        ],
      ),
    );
  }
}

final class _TripDetailFailure extends StatelessWidget {
  const _TripDetailFailure({required this.controller});

  final TripDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            children: [
              const Icon(Icons.route_outlined, size: 56),
              const SizedBox(height: 18),
              Text(
                'Detail trip belum dapat dimuat',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                controller.failure?.message ??
                    'Terjadi kesalahan ketika mengambil detail trip.',
                textAlign: TextAlign.center,
              ),
              if (controller.failure?.requestId case final requestId?) ...[
                const SizedBox(height: 6),
                Text(
                  'Referensi: $requestId',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 22),
              FilledButton.icon(
                key: const Key('trip-detail-retry'),
                onPressed: controller.retry,
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

final class _TripDetailContent extends StatelessWidget {
  const _TripDetailContent({required this.trip, required this.onRefresh});

  final FleetTripDetail trip;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final status = _tripStatusPresentation(trip.status);
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        key: const Key('trip-detail-screen'),
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  trip.vehiclePlateNumber,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              _DetailPill(label: status.$1, color: status.$2),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${trip.vehicleCode} · ${trip.vehicleDescription}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          _DetailSection(
            title: 'Perjalanan',
            children: [
              _DetailRow(label: 'Keperluan', value: trip.purpose),
              _DetailRow(
                label: 'Tujuan',
                value: trip.destination ?? 'Tidak dicantumkan',
              ),
              _DetailRow(label: 'Pengemudi', value: trip.driverName),
              if (trip.driverEmail case final email?)
                _DetailRow(label: 'Email', value: email),
              _DetailRow(
                label: 'Berangkat',
                value: _formatDateTime(trip.departedAt),
              ),
              if (trip.arrivedAt case final arrivedAt?)
                _DetailRow(label: 'Tiba', value: _formatDateTime(arrivedAt)),
              if (trip.cancelledAt case final cancelledAt?)
                _DetailRow(
                  label: 'Dibatalkan',
                  value: _formatDateTime(cancelledAt),
                ),
              _DetailRow(
                label: 'Odometer awal',
                value: '${trip.startOdometer} km',
              ),
              if (trip.endOdometer case final endOdometer?)
                _DetailRow(label: 'Odometer akhir', value: '$endOdometer km'),
              if (trip.completionNote case final note?)
                _DetailRow(label: 'Catatan selesai', value: note),
              if (trip.cancelReason case final reason?)
                _DetailRow(label: 'Alasan batal', value: reason),
            ],
          ),
          const SizedBox(height: 20),
          if (trip.checklist case final checklist?)
            _ChecklistSection(checklist: checklist)
          else
            const _DetailSection(
              title: 'Checklist keberangkatan',
              children: [Text('Trip ini tidak memiliki snapshot checklist.')],
            ),
        ],
      ),
    );
  }
}

final class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

final class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

final class _ChecklistSection extends StatelessWidget {
  const _ChecklistSection({required this.checklist});

  final FleetChecklistSubmission checklist;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Checklist keberangkatan',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          '${checklist.templateName} · versi ${checklist.templateVersion}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          'Dikirim ${_formatDateTime(checklist.submittedAt)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        for (final answer in checklist.answers) ...[
          _ChecklistAnswerCard(answer: answer),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

final class _ChecklistAnswerCard extends StatelessWidget {
  const _ChecklistAnswerCard({required this.answer});

  final FleetChecklistAnswer answer;

  @override
  Widget build(BuildContext context) {
    final result = _checklistResultPresentation(answer.result);
    return Card(
      key: Key('checklist-answer-${answer.id}'),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 15, child: Text('${answer.lineNumber}')),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    answer.label,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                _DetailPill(label: result.$1, color: result.$2),
              ],
            ),
            if (answer.isCritical || answer.isRequired) ...[
              const SizedBox(height: 9),
              Wrap(
                spacing: 6,
                children: [
                  if (answer.isRequired) const Chip(label: Text('Wajib')),
                  if (answer.isCritical) const Chip(label: Text('Kritis')),
                ],
              ),
            ],
            if (answer.note case final note?) ...[
              const SizedBox(height: 8),
              Text('Catatan: $note'),
            ],
            if (answer.evidence.isNotEmpty) ...[
              const SizedBox(height: 10),
              for (final evidence in answer.evidence)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(evidence.originalName),
                            Text(
                              _evidenceMetadata(evidence),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

final class _DetailPill extends StatelessWidget {
  const _DetailPill({required this.label, required this.color});

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

(String, Color) _tripStatusPresentation(FleetTripStatus status) {
  return switch (status) {
    FleetTripStatus.active => ('Aktif', Colors.blue),
    FleetTripStatus.completed => ('Selesai', Colors.green),
    FleetTripStatus.cancelled => ('Dibatalkan', Colors.red),
    FleetTripStatus.unknown => ('Tidak dikenal', Colors.grey),
  };
}

(String, Color) _checklistResultPresentation(FleetChecklistResult result) {
  return switch (result) {
    FleetChecklistResult.pass => ('Lulus', Colors.green),
    FleetChecklistResult.fail => ('Gagal', Colors.red),
    FleetChecklistResult.notApplicable => ('N/A', Colors.grey),
    FleetChecklistResult.unknown => ('Tidak dikenal', Colors.grey),
  };
}

String _formatDateTime(DateTime value) {
  final local = value.toLocal();
  String two(int number) => number.toString().padLeft(2, '0');
  return '${two(local.day)}/${two(local.month)}/${local.year} '
      '${two(local.hour)}:${two(local.minute)}';
}

String _formatBytes(int? bytes) {
  if (bytes == null) return '';
  if (bytes < 1024) return '$bytes B';
  final kib = bytes / 1024;
  if (kib < 1024) return '${kib.toStringAsFixed(1)} KB';
  return '${(kib / 1024).toStringAsFixed(1)} MB';
}

String _evidenceMetadata(FleetChecklistEvidence evidence) {
  final scan = switch (evidence.scanStatus) {
    FleetEvidenceScanStatus.clean => 'Scan bersih',
    FleetEvidenceScanStatus.skipped => 'Scan dilewati',
    FleetEvidenceScanStatus.unknown => 'Status scan tidak dikenal',
  };
  final size = _formatBytes(evidence.size);
  return [
    ?evidence.mimeType,
    if (size.isNotEmpty) size,
    scan,
  ].join(' · ');
}
