<?php

namespace Database\Seeders;

use App\Models\Company;
use App\Models\Department;
use App\Models\DocumentSequenceRule;
use App\Models\Location;
use App\Models\Permission;
use App\Models\Role;
use Illuminate\Database\Seeder;

class FoundationSeeder extends Seeder
{
    public function run(): void
    {
        $companies = [
            'RKS' => 'PT Rajawali Kreatif Sentosa',
            'RKSINERGI' => 'PT Rajawali Kreatif Sinergi',
        ];

        $departments = [
            'RETAIL' => 'Retail',
            'DELIVERY' => 'Delivery',
            'OUTBOUND' => 'Outbound',
            'HR' => 'HR',
            'GA' => 'GA',
            'FINANCE' => 'Finance',
            'OPERATION_EXCELLENCE' => 'Operation Excellence',
            'IT' => 'IT',
        ];

        foreach ($companies as $code => $legalName) {
            $company = Company::query()->firstOrCreate(
                ['code' => $code],
                ['legal_name' => $legalName, 'status' => 'active'],
            );

            foreach ($departments as $departmentCode => $name) {
                Department::query()->firstOrCreate(
                    ['company_id' => $company->id, 'code' => $departmentCode],
                    ['name' => $name, 'status' => 'active'],
                );
            }

            if ($code === 'RKS') {
                $location = Location::query()->firstOrCreate(
                    ['company_id' => $company->id, 'code' => 'KRESEK'],
                    ['name' => 'Warehouse Kresek', 'timezone' => 'Asia/Jakarta', 'status' => 'active'],
                );
                DocumentSequenceRule::query()->firstOrCreate(
                    [
                        'company_id' => $company->id,
                        'location_id' => $location->id,
                        'document_type' => 'maintenance.work_order',
                        'version' => 1,
                    ],
                    [
                        'type_code' => 'WO',
                        'pattern' => '{TYPE}/{COMPANY}/{LOCATION}/{YYYY}/{MM}/{SEQ}',
                        'period' => 'monthly',
                        'padding' => 5,
                        'timezone' => 'Asia/Jakarta',
                        'effective_from' => '2020-01-01',
                    ],
                );
            }
        }

        $permissions = collect([
            ['identity.user.view', 'identity', 'user', 'view'],
            ['identity.user.manage', 'identity', 'user', 'manage'],
            ['identity.user.status.manage', 'identity', 'user-status', 'manage'],
            ['identity.employment.manage', 'identity', 'employment', 'manage'],
            ['identity.access.assign', 'identity', 'access', 'assign'],
            ['identity.access.request', 'identity', 'access', 'request'],
            ['identity.access.approve', 'identity', 'access', 'approve'],
            ['identity.access.revoke', 'identity', 'access', 'revoke'],
            ['identity.role.view', 'identity', 'role', 'view'],
            ['identity.role.manage', 'identity', 'role', 'manage'],
            ['audit.log.view', 'audit', 'log', 'view'],
            ['audit.export.create', 'audit', 'export', 'create'],
            ['file.asset.create', 'file', 'asset', 'create'],
            ['file.asset.view', 'file', 'asset', 'view'],
            ['file.asset.delete', 'file', 'asset', 'delete'],
            ['fleet.vehicle.view', 'fleet', 'vehicle', 'view'],
            ['fleet.vehicle.manage', 'fleet', 'vehicle', 'manage'],
            ['fleet.checklist.submit', 'fleet', 'checklist', 'submit'],
            ['maintenance.work-order.view', 'maintenance', 'work-order', 'view'],
            ['maintenance.work-order.manage', 'maintenance', 'work-order', 'manage'],
        ])->mapWithKeys(function (array $definition): array {
            [$code, $module, $resource, $action] = $definition;

            $permission = Permission::query()->firstOrCreate(
                ['code' => $code],
                compact('module', 'resource', 'action'),
            );

            return [$code => $permission];
        });

        $roles = [
            'platform-admin' => ['Platform Administrator', true, 'global'],
            'security-admin' => ['Security Administrator', true, 'global'],
            'hr-administrator' => ['HR Administrator', true, 'company'],
            'management-access-owner' => ['Management Access Owner', true, 'company'],
            'department-manager' => ['Department Manager', false, 'department'],
            'fleet-manager' => ['Fleet Manager', false, 'location'],
            'maintenance-officer' => ['Maintenance Officer', false, 'location'],
            'auditor' => ['Auditor', true, 'global'],
        ];

        foreach ($roles as $code => [$name, $isPrivileged, $assignmentScope]) {
            Role::query()->updateOrCreate(
                ['code' => $code],
                [
                    'name' => $name,
                    'is_system' => true,
                    'is_privileged' => $isPrivileged,
                    'assignment_scope' => $assignmentScope,
                ],
            );
        }

        Role::query()->where('code', 'platform-admin')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions->pluck('id'));

        Role::query()->where('code', 'security-admin')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only([
                'identity.user.view',
                'identity.user.manage',
                'identity.user.status.manage',
                'identity.access.request',
                'identity.access.revoke',
                'identity.role.view',
                'identity.role.manage',
                'audit.log.view',
            ])
            ->pluck('id'));

        Role::query()->where('code', 'hr-administrator')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only(['identity.user.view', 'identity.employment.manage'])
            ->pluck('id'));

        Role::query()->where('code', 'management-access-owner')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only(['identity.user.view', 'identity.access.assign', 'identity.access.approve', 'identity.access.revoke', 'audit.log.view'])
            ->pluck('id'));

        Role::query()->where('code', 'fleet-manager')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only([
                'file.asset.create',
                'file.asset.view',
                'file.asset.delete',
                'fleet.vehicle.view',
                'fleet.vehicle.manage',
                'maintenance.work-order.view',
            ])
            ->pluck('id'));

        Role::query()->where('code', 'maintenance-officer')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only([
                'file.asset.create',
                'file.asset.view',
                'file.asset.delete',
                'fleet.vehicle.view',
                'maintenance.work-order.view',
                'maintenance.work-order.manage',
            ])
            ->pluck('id'));

        Role::query()->where('code', 'auditor')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only(['audit.log.view', 'audit.export.create'])
            ->pluck('id'));
    }
}
