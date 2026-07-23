// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add($CompanySummary.serializer)
      ..add($CustomRoleProfile.serializer)
      ..add($IdentitySummary.serializer)
      ..add($RecoveryCodeSet.serializer)
      ..add($RoleChangeReason.serializer)
      ..add($RolePermissionSummary.serializer)
      ..add($RoleSummary.serializer)
      ..add($TokenResponse.serializer)
      ..add($UserSummary.serializer)
      ..add(AcceptInvitationRequest.serializer)
      ..add(AccessApprovalResponse.serializer)
      ..add(AccessCatalogResponse.serializer)
      ..add(AccessCatalogResponseData.serializer)
      ..add(AccessCatalogRole.serializer)
      ..add(AccessCatalogRoleAssignmentScopeEnum.serializer)
      ..add(AccessCatalogUser.serializer)
      ..add(AccessDecision.serializer)
      ..add(AccessRejection.serializer)
      ..add(AccessRequestPage.serializer)
      ..add(AccessRequestStatus.serializer)
      ..add(AccessRevocation.serializer)
      ..add(AccessRevocationResponse.serializer)
      ..add(CancelVehicleTripRequest.serializer)
      ..add(ChangeIdentityStatus200Response.serializer)
      ..add(ChangeIdentityStatusRequest.serializer)
      ..add(ChangeIdentityStatusRequestStatusEnum.serializer)
      ..add(ChangeVehicleStatusRequest.serializer)
      ..add(CheckInVehicleRequest.serializer)
      ..add(ChecklistAnswer.serializer)
      ..add(ChecklistAnswerInput.serializer)
      ..add(ChecklistAnswerInputResultEnum.serializer)
      ..add(ChecklistAnswerResultEnum.serializer)
      ..add(ChecklistEvidence.serializer)
      ..add(ChecklistEvidenceScanStatusEnum.serializer)
      ..add(ChecklistSubmission.serializer)
      ..add(ChecklistTemplate.serializer)
      ..add(ChecklistTemplateItem.serializer)
      ..add(ChecklistTemplateStatusEnum.serializer)
      ..add(CheckoutVehicle201Response.serializer)
      ..add(CheckoutVehicleRequest.serializer)
      ..add(CompanyMembership.serializer)
      ..add(CreateInvitationRequest.serializer)
      ..add(CreateMaintenanceWorkOrder201Response.serializer)
      ..add(CreatePrivilegedAccessRequest.serializer)
      ..add(CreateRoleRequest.serializer)
      ..add(CreateStandardRoleAssignmentRequest.serializer)
      ..add(CreateVehicle201Response.serializer)
      ..add(CreateVehicleRequest.serializer)
      ..add(CreateVehicleRequestOwnershipTypeEnum.serializer)
      ..add(CreateVehicleType201Response.serializer)
      ..add(CreateVehicleTypeRequest.serializer)
      ..add(CreateWorkOrderRequest.serializer)
      ..add(CreateWorkOrderRequestJobsInner.serializer)
      ..add(CreateWorkOrderRequestPriorityEnum.serializer)
      ..add(CurrentUser.serializer)
      ..add(CustomRoleProfileAssignmentScopeEnum.serializer)
      ..add(DepartmentMembership.serializer)
      ..add(DepartmentSummary.serializer)
      ..add(DeviceSession.serializer)
      ..add(DeviceSessionSurfaceEnum.serializer)
      ..add(EmploymentStatus.serializer)
      ..add(Error.serializer)
      ..add(FileAsset.serializer)
      ..add(FileAssetScanStatusEnum.serializer)
      ..add(FileAssetStatusEnum.serializer)
      ..add(FileInitiatedResponse.serializer)
      ..add(FileInitiatedResponseUpload.serializer)
      ..add(FileResponse.serializer)
      ..add(GetActiveVehicleChecklistTemplate200Response.serializer)
      ..add(GetIdentityOrganization200Response.serializer)
      ..add(GetIdentityUser200Response.serializer)
      ..add(GetLiveness200Response.serializer)
      ..add(GetOperationsContext200Response.serializer)
      ..add(IdentityCompany.serializer)
      ..add(IdentityCompanyCapabilities.serializer)
      ..add(IdentityCompanyCollection.serializer)
      ..add(IdentityCompanyCollectionMeta.serializer)
      ..add(IdentityStatus.serializer)
      ..add(IdentityUser.serializer)
      ..add(IdentityUserPage.serializer)
      ..add(InitiateFileRequest.serializer)
      ..add(InitiateFileRequestMimeTypeEnum.serializer)
      ..add(InitiateFileRequestPurposeEnum.serializer)
      ..add(InvitationResponse.serializer)
      ..add(ListSessions200Response.serializer)
      ..add(ListVehicleTypes200Response.serializer)
      ..add(LocationMembership.serializer)
      ..add(LocationSummary.serializer)
      ..add(Login200Response.serializer)
      ..add(LoginRequest.serializer)
      ..add(LoginRequestSurfaceEnum.serializer)
      ..add(MaintenanceWorkOrder.serializer)
      ..add(MaintenanceWorkOrderPriorityEnum.serializer)
      ..add(ManagedRole.serializer)
      ..add(MarkAllNotificationsRead200Response.serializer)
      ..add(MfaActivation.serializer)
      ..add(MfaChallenge.serializer)
      ..add(MfaChallengeResponse.serializer)
      ..add(MfaChallengeResponseMethodEnum.serializer)
      ..add(MfaStatus.serializer)
      ..add(MfaStatusStatusEnum.serializer)
      ..add(MobileTokenResponse.serializer)
      ..add(NotificationPage.serializer)
      ..add(NotificationPageMeta.serializer)
      ..add(NotificationResponse.serializer)
      ..add(OperationsCapabilities.serializer)
      ..add(OperationsContext.serializer)
      ..add(OperationsContextCompany.serializer)
      ..add(OperationsContextLocation.serializer)
      ..add(OrganizationCatalog.serializer)
      ..add(OrganizationMembershipUpdateResponse.serializer)
      ..add(PasswordConfirmation.serializer)
      ..add(PasswordResetRequest.serializer)
      ..add(PlatformNotification.serializer)
      ..add(PlatformNotificationDeliveriesEnum.serializer)
      ..add(PrivilegedAccessRequest.serializer)
      ..add(PrivilegedRoleAssignment.serializer)
      ..add(PrivilegedRoleAssignmentRole.serializer)
      ..add(ReadinessResponse.serializer)
      ..add(ReadinessResponseChecksValue.serializer)
      ..add(ReadinessResponseChecksValueStatusEnum.serializer)
      ..add(ReadinessResponseStatusEnum.serializer)
      ..add(RefreshMobileTokenRequest.serializer)
      ..add(RequestPasswordReset202Response.serializer)
      ..add(RequestPasswordResetRequest.serializer)
      ..add(ResetPassword200Response.serializer)
      ..add(RevokeAllSessions200Response.serializer)
      ..add(RevokeAllSessionsRequest.serializer)
      ..add(RevokeSession200Response.serializer)
      ..add(RevokeStandardRoleAssignmentRequest.serializer)
      ..add(RoleAssignmentPage.serializer)
      ..add(RoleAssignmentScope.serializer)
      ..add(RoleCatalogPermission.serializer)
      ..add(RoleCatalogResponse.serializer)
      ..add(RoleCatalogResponseData.serializer)
      ..add(RoleCatalogResponseMeta.serializer)
      ..add(RoleMutationResponse.serializer)
      ..add(RoleMutationResponseData.serializer)
      ..add(StandardAccessCatalogResponse.serializer)
      ..add(StandardAccessCatalogResponseData.serializer)
      ..add(StandardAccessRole.serializer)
      ..add(StandardAccessRoleAssignmentScopeEnum.serializer)
      ..add(StandardRoleAssignment.serializer)
      ..add(StandardRoleAssignmentResponse.serializer)
      ..add(StandardRoleAssignmentRole.serializer)
      ..add(StandardRoleAssignmentRoleIsPrivilegedEnum.serializer)
      ..add(StandardRoleAssignmentStatusEnum.serializer)
      ..add(SyncRolePermissionsRequest.serializer)
      ..add(TerminateCompanyMembershipRequest.serializer)
      ..add(TotpCode.serializer)
      ..add(TotpEnrollment.serializer)
      ..add(TransitionWorkOrderRequest.serializer)
      ..add(TransitionWorkOrderRequestStatusEnum.serializer)
      ..add(UpdateOrganizationMembershipsRequest.serializer)
      ..add(Vehicle.serializer)
      ..add(VehicleOwnershipTypeEnum.serializer)
      ..add(VehiclePage.serializer)
      ..add(VehicleStatus.serializer)
      ..add(VehicleTrip.serializer)
      ..add(VehicleTripPage.serializer)
      ..add(VehicleTripStatus.serializer)
      ..add(VehicleType.serializer)
      ..add(WorkOrderJob.serializer)
      ..add(WorkOrderJobStatusEnum.serializer)
      ..add(WorkOrderPage.serializer)
      ..add(WorkOrderStatus.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(AccessCatalogUser)]),
          () => ListBuilder<AccessCatalogUser>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(AccessCatalogRole)]),
          () => ListBuilder<AccessCatalogRole>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ChecklistAnswer)]),
          () => ListBuilder<ChecklistAnswer>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(ChecklistAnswerInput)]),
          () => ListBuilder<ChecklistAnswerInput>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ChecklistEvidence)]),
          () => ListBuilder<ChecklistEvidence>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(ChecklistTemplateItem)]),
          () => ListBuilder<ChecklistTemplateItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CompanyMembership)]),
          () => ListBuilder<CompanyMembership>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(DepartmentMembership)]),
          () => ListBuilder<DepartmentMembership>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(LocationMembership)]),
          () => ListBuilder<LocationMembership>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(CreateWorkOrderRequestJobsInner)]),
          () => ListBuilder<CreateWorkOrderRequestJobsInner>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(DepartmentSummary)]),
          () => ListBuilder<DepartmentSummary>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(LocationSummary)]),
          () => ListBuilder<LocationSummary>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(DeviceSession)]),
          () => ListBuilder<DeviceSession>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(IdentityCompany)]),
          () => ListBuilder<IdentityCompany>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(IdentityUser)]),
          () => ListBuilder<IdentityUser>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(MaintenanceWorkOrder)]),
          () => ListBuilder<MaintenanceWorkOrder>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ManagedRole)]),
          () => ListBuilder<ManagedRole>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(RoleCatalogPermission)]),
          () => ListBuilder<RoleCatalogPermission>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(OperationsContext)]),
          () => ListBuilder<OperationsContext>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(PlatformNotification)]),
          () => ListBuilder<PlatformNotification>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(PrivilegedAccessRequest)]),
          () => ListBuilder<PrivilegedAccessRequest>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(PrivilegedRoleAssignment)]),
          () => ListBuilder<PrivilegedRoleAssignment>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(RolePermissionSummary)]),
          () => ListBuilder<RolePermissionSummary>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(StandardAccessRole)]),
          () => ListBuilder<StandardAccessRole>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(StandardRoleAssignment)]),
          () => ListBuilder<StandardRoleAssignment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Vehicle)]),
          () => ListBuilder<Vehicle>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(VehicleTrip)]),
          () => ListBuilder<VehicleTrip>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(VehicleType)]),
          () => ListBuilder<VehicleType>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(WorkOrderJob)]),
          () => ListBuilder<WorkOrderJob>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltList, const [const FullType(String)])
          ]),
          () => MapBuilder<String, BuiltList<String>>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(ReadinessResponseChecksValue)
          ]),
          () => MapBuilder<String, ReadinessResponseChecksValue>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType.nullable(JsonObject)
          ]),
          () => MapBuilder<String, JsonObject?>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(PlatformNotificationDeliveriesEnum)
          ]),
          () => MapBuilder<String, PlatformNotificationDeliveriesEnum>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltSet, const [const FullType(String)]),
          () => SetBuilder<String>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
