final class OperatorIdentity {
  const OperatorIdentity({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;
}

final class LegalEntity {
  const LegalEntity({
    required this.id,
    required this.code,
    required this.legalName,
  });

  final String id;
  final String code;
  final String legalName;
}

final class WorkLocation {
  const WorkLocation({
    required this.id,
    required this.code,
    required this.name,
    required this.timezone,
  });

  final String id;
  final String code;
  final String name;
  final String timezone;
}

final class MobileOperationsCapabilities {
  const MobileOperationsCapabilities({
    required this.canViewVehicles,
    required this.canManageVehicles,
    required this.canViewWorkOrders,
    required this.canManageWorkOrders,
    required this.canViewTrips,
    required this.canOperateTrips,
    required this.canManageTrips,
  });

  final bool canViewVehicles;
  final bool canManageVehicles;
  final bool canViewWorkOrders;
  final bool canManageWorkOrders;
  final bool canViewTrips;
  final bool canOperateTrips;
  final bool canManageTrips;
}

final class OperationsWorkspace {
  const OperationsWorkspace({
    required this.company,
    required this.location,
    required this.capabilities,
  });

  final LegalEntity company;
  final WorkLocation location;
  final MobileOperationsCapabilities capabilities;

  String get key => '${company.id}:${location.id}';
}

final class OperationsBootstrapData {
  const OperationsBootstrapData({
    required this.identity,
    required this.workspaces,
  });

  final OperatorIdentity identity;
  final List<OperationsWorkspace> workspaces;
}
