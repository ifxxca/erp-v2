# Domain Model dan Logical ERD

Status: baseline desain untuk implementasi. Dokumen ini bukan salinan database ERP lama dan belum menggantikan migration sebagai definisi fisik schema.

## Prinsip model data

- Semua primary key menggunakan UUID/ULID dan tidak bergantung pada ID legacy.
- Tabel transaksi menyimpan status eksplisit, timestamp, dan aktor perubahan penting.
- Nilai uang disimpan sebagai decimal dan selalu memiliki currency.
- Waktu disimpan dalam UTC; tampilan mengikuti timezone lokasi atau pengguna.
- Soft delete hanya dipakai pada master data yang memang boleh dipulihkan. Transaksi finansial tidak dihapus; koreksi dilakukan melalui reversal atau adjustment.
- Referensi dokumen bisnis memakai nomor yang dibangkitkan server, bukan `MAX(id) + 1`.
- File disimpan di object storage; database hanya menyimpan metadata dan checksum.
- Integrasi asynchronous memakai outbox agar perubahan data dan event tercatat atomik.
- Seluruh aggregate bisnis memiliki `company_id`; data antar-legal-entity tidak boleh bercampur walaupun berada pada database yang sama.

## Peta bounded module

```mermaid
flowchart LR
    IAM["Identity & Access"] --> WF["Workflow & Approval"]
    IAM --> PRC["Procurement"]
    IAM --> FIN["Finance"]
    IAM --> INV["Inventory & Assets"]
    IAM --> FLT["Fleet"]
    IAM --> OPS["Pickup & Operations"]
    IAM --> SVC["Service & Maintenance"]
    IAM --> SUP["Support"]
    PRC --> INV
    PRC --> FIN
    FLT --> OPS
    FLT --> SVC
    INV --> SVC
    WF --> PRC
    WF --> FIN
    WF --> SVC
```

## 1. Identity, organization, dan authorization

`users` tidak memiliki kolom `role_id` atau `department_id`. Hubungan organisasi dan hak akses memiliki lifecycle sendiri.

```mermaid
erDiagram
    USERS ||--o{ USER_COMPANY_MEMBERSHIPS : belongs_to
    COMPANIES ||--o{ USER_COMPANY_MEMBERSHIPS : employs
    COMPANIES ||--o{ DEPARTMENTS : owns
    COMPANIES ||--o{ LOCATIONS : owns
    USERS ||--o{ USER_DEPARTMENT_MEMBERSHIPS : belongs_to
    DEPARTMENTS ||--o{ USER_DEPARTMENT_MEMBERSHIPS : has
    DEPARTMENTS ||--o{ DEPARTMENTS : parent_of
    USERS ||--o{ USER_ROLE_ASSIGNMENTS : receives
    ROLES ||--o{ USER_ROLE_ASSIGNMENTS : assigned_as
    COMPANIES o|--o{ USER_ROLE_ASSIGNMENTS : scopes_company
    DEPARTMENTS o|--o{ USER_ROLE_ASSIGNMENTS : scopes_department
    LOCATIONS o|--o{ USER_ROLE_ASSIGNMENTS : scopes_location
    ROLES ||--o{ ROLE_PERMISSIONS : grants
    PERMISSIONS ||--o{ ROLE_PERMISSIONS : included_in
    USERS ||--o{ AUDIT_LOGS : acts

    USERS {
        uuid id PK
        string name
        string email UK
        string password_hash
        enum status
        datetime last_login_at
    }
    COMPANIES {
        uuid id PK
        string code UK
        string legal_name UK
        string tax_identifier
        enum status
    }
    USER_COMPANY_MEMBERSHIPS {
        uuid id PK
        uuid user_id FK
        uuid company_id FK
        string employee_no
        enum employment_status
        boolean is_primary
        date valid_from
        date valid_until
    }
    DEPARTMENTS {
        uuid id PK
        uuid company_id FK
        uuid parent_id FK
        string code
        string name
        enum status
    }
    LOCATIONS {
        uuid id PK
        uuid company_id FK
        string code
        string name
        string timezone
        enum status
    }
    USER_DEPARTMENT_MEMBERSHIPS {
        uuid id PK
        uuid user_id FK
        uuid department_id FK
        boolean is_primary
        date valid_from
        date valid_until
    }
    ROLES {
        uuid id PK
        string code UK
        string name
        string description
        boolean is_system
    }
    PERMISSIONS {
        uuid id PK
        string code UK
        string module
        string action
    }
    ROLE_PERMISSIONS {
        uuid role_id FK
        uuid permission_id FK
    }
    USER_ROLE_ASSIGNMENTS {
        uuid id PK
        uuid user_id FK
        uuid role_id FK
        uuid company_id FK
        uuid department_id FK
        uuid location_id FK
        datetime valid_from
        datetime valid_until
        uuid assigned_by FK
    }
    AUDIT_LOGS {
        uuid id PK
        uuid company_id FK
        uuid actor_user_id FK
        string action
        string subject_type
        uuid subject_id
        json before_data
        json after_data
        string request_id
        datetime occurred_at
    }
```

Aturan penting:

- Company awal adalah `RKS` (PT Rajawali Kreatif Sentosa) dan `RKSINERGI` (PT Rajawali Kreatif Sinergi).
- User identity dapat dipakai lintas company, tetapi membership dan role assignment harus diberikan secara eksplisit untuk setiap company.
- Department awal per company: Retail, Delivery, Outbound, HR, GA, Finance, Operation Excellence, dan IT. Company dapat menonaktifkan department yang tidak berlaku tanpa mengubah katalog platform.
- Kode department dan location unik di dalam company, bukan global.
- Satu user boleh menjadi anggota beberapa departemen, tetapi hanya satu membership aktif yang primary.
- Role assignment selalu memiliki company scope; di dalamnya dapat dibatasi lagi berdasarkan departemen dan/atau lokasi.
- Permission menggunakan pola `module.resource.action`, misalnya `procurement.purchase-request.approve`.
- Hak efektif dihitung dari assignment yang aktif dan scope request. Tidak ada pengecekan role menggunakan ID hardcoded.
- Menonaktifkan user segera membatalkan session dan akses API, tanpa menghapus histori transaksinya.

## 2. Workflow dan approval

Workflow bersifat configurable, tetapi versi workflow yang sudah dipakai transaksi tidak boleh berubah secara retroaktif.

```mermaid
erDiagram
    APPROVAL_WORKFLOWS ||--|{ APPROVAL_WORKFLOW_STEPS : defines
    APPROVAL_WORKFLOWS ||--o{ APPROVAL_INSTANCES : instantiates
    APPROVAL_INSTANCES ||--|{ APPROVAL_INSTANCE_STEPS : contains
    APPROVAL_INSTANCE_STEPS ||--o{ APPROVAL_ACTIONS : records
    USERS ||--o{ APPROVAL_ACTIONS : performs

    APPROVAL_WORKFLOWS {
        uuid id PK
        string code
        int version
        string subject_type
        enum status
        json activation_condition
    }
    APPROVAL_WORKFLOW_STEPS {
        uuid id PK
        uuid workflow_id FK
        int sequence
        string approver_permission
        enum scope_strategy
        decimal amount_min
        decimal amount_max
    }
    APPROVAL_INSTANCES {
        uuid id PK
        uuid company_id FK
        uuid workflow_id FK
        string subject_type
        uuid subject_id
        enum status
        datetime submitted_at
        datetime completed_at
    }
    APPROVAL_INSTANCE_STEPS {
        uuid id PK
        uuid instance_id FK
        int sequence
        enum status
        uuid resolved_approver_id FK
        datetime due_at
    }
    APPROVAL_ACTIONS {
        uuid id PK
        uuid instance_step_id FK
        uuid actor_user_id FK
        enum action
        string comment
        datetime acted_at
    }
```

## 3. Procurement, inventory, dan finance

```mermaid
erDiagram
    SUPPLIERS ||--o{ PURCHASE_ORDERS : receives
    PURCHASE_REQUESTS ||--|{ PURCHASE_REQUEST_ITEMS : contains
    PURCHASE_REQUESTS ||--o{ PURCHASE_ORDERS : sourced_as
    PURCHASE_ORDERS ||--|{ PURCHASE_ORDER_ITEMS : contains
    PURCHASE_ORDERS ||--o{ GOODS_RECEIPTS : received_by
    GOODS_RECEIPTS ||--|{ GOODS_RECEIPT_ITEMS : contains
    ITEMS ||--o{ PURCHASE_REQUEST_ITEMS : requested
    ITEMS ||--o{ PURCHASE_ORDER_ITEMS : ordered
    ITEMS ||--o{ GOODS_RECEIPT_ITEMS : received
    ITEMS ||--o{ INVENTORY_MOVEMENTS : moves
    INVENTORY_LOCATIONS ||--o{ INVENTORY_MOVEMENTS : hosts
    ITEMS ||--o{ INVENTORY_BALANCES : balances
    INVENTORY_LOCATIONS ||--o{ INVENTORY_BALANCES : stores
    PURCHASE_ORDERS ||--o{ PAYMENT_SCHEDULES : paid_by
    PAYMENT_SCHEDULES ||--|{ PAYMENT_SCHEDULE_LINES : splits
    PAYMENT_TRANSACTIONS ||--o{ PAYMENT_ALLOCATIONS : allocates
    PAYMENT_SCHEDULE_LINES ||--o{ PAYMENT_ALLOCATIONS : settles
    PAYMENT_ACCOUNTS ||--o{ PAYMENT_TRANSACTIONS : funds

    PURCHASE_REQUESTS {
        uuid id PK
        uuid company_id FK
        string number UK
        uuid requester_id FK
        uuid department_id FK
        enum status
        string purpose
        datetime submitted_at
    }
    PURCHASE_REQUEST_ITEMS {
        uuid id PK
        uuid purchase_request_id FK
        uuid item_id FK
        string description
        decimal quantity
        string unit
        decimal estimated_unit_price
    }
    SUPPLIERS {
        uuid id PK
        uuid company_id FK
        string code UK
        string name
        string tax_no
        enum status
    }
    PURCHASE_ORDERS {
        uuid id PK
        uuid company_id FK
        string number UK
        uuid purchase_request_id FK
        uuid supplier_id FK
        enum status
        string currency
        decimal total_amount
    }
    PURCHASE_ORDER_ITEMS {
        uuid id PK
        uuid purchase_order_id FK
        uuid item_id FK
        decimal quantity
        decimal unit_price
        decimal tax_amount
    }
    GOODS_RECEIPTS {
        uuid id PK
        uuid company_id FK
        string number UK
        uuid purchase_order_id FK
        uuid inventory_location_id FK
        enum status
        datetime received_at
    }
    GOODS_RECEIPT_ITEMS {
        uuid id PK
        uuid goods_receipt_id FK
        uuid purchase_order_item_id FK
        uuid item_id FK
        decimal accepted_quantity
        decimal rejected_quantity
    }
    ITEMS {
        uuid id PK
        uuid company_id FK
        string sku UK
        string name
        uuid category_id FK
        string base_unit
        enum tracking_type
        enum status
    }
    INVENTORY_LOCATIONS {
        uuid id PK
        uuid company_id FK
        string code UK
        string name
        uuid location_id FK
        enum type
    }
    INVENTORY_MOVEMENTS {
        uuid id PK
        uuid company_id FK
        uuid item_id FK
        uuid inventory_location_id FK
        enum movement_type
        decimal quantity
        decimal unit_cost
        decimal value_delta
        string reference_type
        uuid reference_id
        datetime occurred_at
    }
    INVENTORY_BALANCES {
        uuid company_id FK
        uuid item_id FK
        uuid inventory_location_id FK
        decimal quantity_on_hand
        decimal average_unit_cost
        decimal inventory_value
        bigint version
    }
    PAYMENT_SCHEDULES {
        uuid id PK
        uuid company_id FK
        uuid payable_id
        string payable_type
        enum status
        decimal total_amount
        string currency
    }
    PAYMENT_SCHEDULE_LINES {
        uuid id PK
        uuid payment_schedule_id FK
        date due_date
        decimal amount
        enum status
    }
    PAYMENT_ACCOUNTS {
        uuid id PK
        uuid company_id FK
        string code UK
        string name
        string account_type
        enum status
    }
    PAYMENT_TRANSACTIONS {
        uuid id PK
        uuid company_id FK
        string number UK
        uuid payment_account_id FK
        enum direction
        decimal amount
        string currency
        enum status
        datetime posted_at
    }
    PAYMENT_ALLOCATIONS {
        uuid id PK
        uuid payment_transaction_id FK
        uuid payment_schedule_line_id FK
        decimal amount
    }
```

Inventory balance adalah projection dari movement, bukan sumber kebenaran kedua, dan harus dapat direkonstruksi. Weighted moving average dihitung atomik per company-item-location pada receipt/positive adjustment; issue memakai average cost sebelum movement. Negative stock tidak diizinkan. Fixed asset memiliki acquisition/depreciation lifecycle sendiri dan tidak memakai valuation stock ini.

## 4. Fleet dan maintenance

```mermaid
erDiagram
    VEHICLE_TYPES ||--o{ VEHICLES : classifies
    VEHICLES ||--o{ VEHICLE_STATUS_HISTORY : changes
    VEHICLES ||--o{ VEHICLE_DOCUMENTS : owns
    VEHICLES ||--o{ VEHICLE_TRIPS : performs
    VEHICLES ||--o{ FUEL_ENTRIES : consumes
    VEHICLES ||--o{ SERVICE_WORK_ORDERS : serviced_by
    SERVICE_WORK_ORDERS ||--|{ SERVICE_WORK_ORDER_ITEMS : contains
    SERVICE_WORK_ORDERS ||--o{ PART_USAGES : uses
    ITEMS ||--o{ PART_USAGES : consumed
    CHECKLIST_TEMPLATES ||--|{ CHECKLIST_TEMPLATE_ITEMS : defines
    VEHICLES ||--o{ CHECKLIST_SUBMISSIONS : checked
    CHECKLIST_SUBMISSIONS ||--|{ CHECKLIST_ANSWERS : answers

    VEHICLES {
        uuid id PK
        uuid company_id FK
        string code UK
        string plate_number UK
        uuid vehicle_type_id FK
        enum operational_status
        decimal current_odometer
        uuid home_location_id FK
    }
    VEHICLE_TYPES {
        uuid id PK
        string code UK
        string name
        decimal load_capacity
    }
    VEHICLE_STATUS_HISTORY {
        uuid id PK
        uuid vehicle_id FK
        enum from_status
        enum to_status
        string reason
        datetime changed_at
    }
    VEHICLE_DOCUMENTS {
        uuid id PK
        uuid vehicle_id FK
        string document_type
        string document_number
        date expires_at
        uuid file_id FK
    }
    VEHICLE_TRIPS {
        uuid id PK
        uuid vehicle_id FK
        uuid driver_id FK
        decimal start_odometer
        decimal end_odometer
        datetime departed_at
        datetime arrived_at
    }
    FUEL_ENTRIES {
        uuid id PK
        uuid vehicle_id FK
        decimal odometer
        decimal quantity
        decimal total_amount
        datetime fueled_at
    }
    SERVICE_WORK_ORDERS {
        uuid id PK
        uuid company_id FK
        string number UK
        uuid vehicle_id FK
        uuid vendor_id FK
        enum status
        decimal odometer
        datetime opened_at
        datetime completed_at
    }
    SERVICE_WORK_ORDER_ITEMS {
        uuid id PK
        uuid work_order_id FK
        string service_type
        string description
        decimal amount
    }
    PART_USAGES {
        uuid id PK
        uuid work_order_id FK
        uuid item_id FK
        decimal quantity
    }
    CHECKLIST_TEMPLATES {
        uuid id PK
        string code
        int version
        enum status
    }
    CHECKLIST_TEMPLATE_ITEMS {
        uuid id PK
        uuid template_id FK
        string prompt
        string answer_type
        boolean is_required
    }
    CHECKLIST_SUBMISSIONS {
        uuid id PK
        uuid template_id FK
        uuid vehicle_id FK
        uuid submitted_by FK
        datetime submitted_at
    }
    CHECKLIST_ANSWERS {
        uuid id PK
        uuid submission_id FK
        uuid template_item_id FK
        json answer
    }
```

## 5. Pickup, return, dan shift operations

```mermaid
erDiagram
    CUSTOMERS ||--o{ PICKUPS : requests
    VEHICLES ||--o{ PICKUPS : assigned
    USERS ||--o{ PICKUPS : drives
    PICKUPS ||--o{ PICKUP_ENTRIES : records
    PICKUP_ENTRIES ||--|{ PICKUP_ENTRY_LINES : contains
    PICKUPS ||--o{ RETURNS : produces
    RETURNS ||--|{ RETURN_ITEMS : contains
    WORK_SHIFTS ||--o{ WORK_SHIFT_MEMBERS : staffed_by
    USERS ||--o{ WORK_SHIFT_MEMBERS : joins
    WORK_SHIFTS ||--o{ WORK_SHIFT_VERIFICATIONS : verified

    CUSTOMERS {
        uuid id PK
        uuid company_id FK
        string code UK
        string name
        string address
        enum status
    }
    PICKUPS {
        uuid id PK
        uuid company_id FK
        string number UK
        uuid customer_id FK
        uuid vehicle_id FK
        uuid driver_id FK
        enum status
        datetime scheduled_at
        datetime completed_at
    }
    PICKUP_ENTRIES {
        uuid id PK
        uuid pickup_id FK
        uuid recorded_by FK
        decimal gross_weight
        decimal net_weight
        datetime recorded_at
    }
    PICKUP_ENTRY_LINES {
        uuid id PK
        uuid pickup_entry_id FK
        string material_type
        decimal quantity
        string unit
        string disposition
    }
    RETURNS {
        uuid id PK
        uuid company_id FK
        string number UK
        uuid pickup_id FK
        enum status
        datetime returned_at
    }
    RETURN_ITEMS {
        uuid id PK
        uuid return_id FK
        string item_description
        decimal quantity
        string reason
    }
    WORK_SHIFTS {
        uuid id PK
        uuid company_id FK
        uuid location_id FK
        datetime starts_at
        datetime ends_at
        enum status
    }
    WORK_SHIFT_MEMBERS {
        uuid id PK
        uuid work_shift_id FK
        uuid user_id FK
        string duty
    }
    WORK_SHIFT_VERIFICATIONS {
        uuid id PK
        uuid work_shift_id FK
        uuid verifier_id FK
        enum result
        string notes
        datetime verified_at
    }
```

## 6. Shared platform records

| Entity | Fungsi |
|---|---|
| `files` | Metadata object, MIME type, size, checksum, owner, dan retention |
| `document_sequences` | Nomor dokumen atomik per tipe, lokasi, dan periode |
| `idempotency_keys` | Mencegah duplikasi command API/mobile |
| `outbox_messages` | Event reliable untuk notification dan integrasi |
| `notifications` | Inbox notification dan delivery status |
| `comments` | Percakapan polymorphic bila domain mengizinkan |
| `audit_logs` | Jejak perubahan immutable untuk operasi sensitif |

## Constraint lintas domain

- Nomor dokumen unik setidaknya per tenant/perusahaan dan tipe dokumen.
- Status berubah hanya melalui domain command yang diizinkan; endpoint update generik tidak boleh mengubah lifecycle transaksi.
- Semua foreign key transaksi menggunakan `RESTRICT`, kecuali child murni yang aman memakai cascade.
- Approval, posting pembayaran, goods receipt, inventory movement, dan perubahan status kendaraan wajib berada dalam database transaction.
- Snapshot nama/harga/alamat hanya ditambahkan bila dokumen hukum atau histori memang harus mempertahankan nilai saat transaksi dibuat.

## Keputusan lanjutan sebelum physical schema domain

- Detail material taxonomy dan unit conversion.
- Detail fixed-asset depreciation policy.
- Integrasi GPS, accounting export, bank statement, serta attendance device.

P0 legal entity, finance scope, inventory valuation, pilot, stack, dan authentication telah diselesaikan di [10-P0-DECISIONS.md](10-P0-DECISIONS.md). Pertanyaan domain berikutnya tetap dilacak di [08-OPEN-QUESTIONS.md](08-OPEN-QUESTIONS.md).
