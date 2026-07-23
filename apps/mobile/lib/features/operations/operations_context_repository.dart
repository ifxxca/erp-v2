import 'package:rajawali_api_client/rajawali_api_client.dart';
import 'package:rajawali_mobile/features/operations/operations_context.dart';

abstract interface class OperationsContextRepository {
  Future<OperationsBootstrapData> load();
}

final class GeneratedOperationsContextRepository
    implements OperationsContextRepository {
  const GeneratedOperationsContextRepository(this._api);

  final DefaultApi _api;

  @override
  Future<OperationsBootstrapData> load() async {
    CurrentUser? identity;
    GetOperationsContext200Response? contexts;
    await Future.wait<void>([
      _api.getCurrentUser().then((response) => identity = response.data),
      _api.getOperationsContext().then((response) => contexts = response.data),
    ]);
    if (identity == null || contexts == null) {
      throw const OperationsContextProtocolException();
    }

    return OperationsBootstrapData(
      identity: OperatorIdentity(
        id: identity!.id,
        name: identity!.name,
        email: identity!.email,
      ),
      workspaces: List.unmodifiable(
        contexts!.data.map(
          (context) => OperationsWorkspace(
            company: LegalEntity(
              id: context.company.id,
              code: context.company.code,
              legalName: context.company.legalName,
            ),
            location: WorkLocation(
              id: context.location.id,
              code: context.location.code,
              name: context.location.name,
              timezone: context.location.timezone,
            ),
            capabilities: MobileOperationsCapabilities(
              canViewVehicles: context.capabilities.canViewVehicles,
              canManageVehicles: context.capabilities.canManageVehicles,
              canViewWorkOrders: context.capabilities.canViewWorkOrders,
              canManageWorkOrders: context.capabilities.canManageWorkOrders,
              canViewTrips: context.capabilities.canViewTrips,
              canOperateTrips: context.capabilities.canOperateTrips,
              canManageTrips: context.capabilities.canManageTrips,
            ),
          ),
        ),
      ),
    );
  }
}

final class OperationsContextProtocolException implements Exception {
  const OperationsContextProtocolException();
}
