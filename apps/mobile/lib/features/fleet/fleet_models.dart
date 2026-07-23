import 'package:rajawali_mobile/features/operations/operations_context.dart';

enum FleetVehicleStatus {
  available,
  inUse,
  maintenance,
  blocked,
  inactive,
  unknown,
}

enum FleetTripStatus { active, completed, cancelled, unknown }

enum FleetChecklistResult { pass, fail, notApplicable, unknown }

enum FleetEvidenceScanStatus { clean, skipped, unknown }

final class FleetVehicle {
  const FleetVehicle({
    required this.id,
    required this.code,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.modelYear,
    required this.currentOdometer,
    required this.status,
    required this.typeName,
  });

  final String id;
  final String code;
  final String plateNumber;
  final String brand;
  final String model;
  final int? modelYear;
  final int currentOdometer;
  final FleetVehicleStatus status;
  final String? typeName;
}

final class FleetTrip {
  const FleetTrip({
    required this.id,
    required this.status,
    required this.purpose,
    required this.destination,
    required this.startOdometer,
    required this.departedAt,
    required this.vehicleId,
    required this.vehiclePlateNumber,
    required this.driverId,
    required this.driverName,
  });

  final String id;
  final FleetTripStatus status;
  final String purpose;
  final String? destination;
  final int startOdometer;
  final DateTime departedAt;
  final String vehicleId;
  final String vehiclePlateNumber;
  final String driverId;
  final String driverName;
}

final class FleetChecklistEvidence {
  const FleetChecklistEvidence({
    required this.id,
    required this.originalName,
    required this.mimeType,
    required this.size,
    required this.scanStatus,
  });

  final String id;
  final String originalName;
  final String? mimeType;
  final int? size;
  final FleetEvidenceScanStatus scanStatus;
}

final class FleetChecklistAnswer {
  const FleetChecklistAnswer({
    required this.id,
    required this.lineNumber,
    required this.label,
    required this.isRequired,
    required this.isCritical,
    required this.result,
    required this.note,
    required this.evidence,
  });

  final String id;
  final int lineNumber;
  final String label;
  final bool isRequired;
  final bool isCritical;
  final FleetChecklistResult result;
  final String? note;
  final List<FleetChecklistEvidence> evidence;
}

final class FleetChecklistSubmission {
  const FleetChecklistSubmission({
    required this.id,
    required this.templateName,
    required this.templateVersion,
    required this.submittedAt,
    required this.answers,
  });

  final String id;
  final String templateName;
  final int templateVersion;
  final DateTime submittedAt;
  final List<FleetChecklistAnswer> answers;
}

final class FleetTripDetail {
  const FleetTripDetail({
    required this.id,
    required this.status,
    required this.purpose,
    required this.destination,
    required this.startOdometer,
    required this.endOdometer,
    required this.departedAt,
    required this.arrivedAt,
    required this.cancelledAt,
    required this.completionNote,
    required this.cancelReason,
    required this.vehicleCode,
    required this.vehiclePlateNumber,
    required this.vehicleDescription,
    required this.driverName,
    required this.driverEmail,
    required this.checklist,
  });

  final String id;
  final FleetTripStatus status;
  final String purpose;
  final String? destination;
  final int startOdometer;
  final int? endOdometer;
  final DateTime departedAt;
  final DateTime? arrivedAt;
  final DateTime? cancelledAt;
  final String? completionNote;
  final String? cancelReason;
  final String vehicleCode;
  final String vehiclePlateNumber;
  final String vehicleDescription;
  final String driverName;
  final String? driverEmail;
  final FleetChecklistSubmission? checklist;
}

final class FleetPage<T> {
  const FleetPage({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  const FleetPage.empty()
    : data = const [],
      currentPage = 1,
      lastPage = 1,
      total = 0;

  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;
}

final class FleetStatusCounts {
  const FleetStatusCounts({
    required this.available,
    required this.inUse,
    required this.maintenance,
  });

  const FleetStatusCounts.empty() : available = 0, inUse = 0, maintenance = 0;

  final int available;
  final int inUse;
  final int maintenance;
}

final class FleetScope {
  const FleetScope({required this.companyId, required this.locationId});

  factory FleetScope.fromWorkspace(OperationsWorkspace workspace) {
    return FleetScope(
      companyId: workspace.company.id,
      locationId: workspace.location.id,
    );
  }

  final String companyId;
  final String locationId;

  String get key => '$companyId:$locationId';
}
