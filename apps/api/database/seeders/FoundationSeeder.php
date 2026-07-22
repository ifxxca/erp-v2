<?php

namespace Database\Seeders;

use App\Models\Company;
use App\Models\Department;
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
        }

        $permissions = collect([
            ['identity.user.view', 'identity', 'user', 'view'],
            ['identity.user.manage', 'identity', 'user', 'manage'],
            ['identity.access.assign', 'identity', 'access', 'assign'],
            ['audit.log.view', 'audit', 'log', 'view'],
            ['audit.export.create', 'audit', 'export', 'create'],
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
            'platform-admin' => ['Platform Administrator', true],
            'security-admin' => ['Security Administrator', true],
            'management-access-owner' => ['Management Access Owner', true],
            'department-manager' => ['Department Manager', false],
            'fleet-manager' => ['Fleet Manager', false],
            'maintenance-officer' => ['Maintenance Officer', false],
            'auditor' => ['Auditor', true],
        ];

        foreach ($roles as $code => [$name, $isPrivileged]) {
            Role::query()->firstOrCreate(
                ['code' => $code],
                ['name' => $name, 'is_system' => true, 'is_privileged' => $isPrivileged],
            );
        }

        Role::query()->where('code', 'platform-admin')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions->pluck('id'));

        Role::query()->where('code', 'security-admin')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only(['identity.user.view', 'identity.user.manage', 'identity.access.assign', 'audit.log.view'])
            ->pluck('id'));

        Role::query()->where('code', 'fleet-manager')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only(['fleet.vehicle.view', 'fleet.vehicle.manage', 'maintenance.work-order.view'])
            ->pluck('id'));

        Role::query()->where('code', 'maintenance-officer')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only(['fleet.vehicle.view', 'maintenance.work-order.view', 'maintenance.work-order.manage'])
            ->pluck('id'));

        Role::query()->where('code', 'auditor')->firstOrFail()
            ->permissions()->syncWithoutDetaching($permissions
            ->only(['audit.log.view', 'audit.export.create'])
            ->pluck('id'));
    }
}
