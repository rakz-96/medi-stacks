# Hospital Appointment and Billing System — Project Documentation

## Problem statement
Hospitals manage patient registration, doctors, appointments, services, bills and payments. Spreadsheet/manual workflows make it difficult to maintain relationships, prevent appointment conflicts and calculate billing consistently. This project provides a centralized relational database application with a REST backend and responsive browser interface.

## Objectives
1. Maintain normalized patient, doctor, department and service data.
2. Book appointments while preventing duplicate doctor slots.
3. Generate bills with multiple service items and server/database-side calculations.
4. Record payments and maintain payment status.
5. Provide dashboard and reporting queries.
6. Demonstrate DBMS concepts in a practical application.

## Scope
Academic/demo hospital operations only. No real patient data, insurance processing, online banking or production authentication is included.

## Functional requirements
Patient CRUD/search; doctor CRUD/search; department CRUD; appointment booking/status; service CRUD; bill creation/item management; payment recording; dashboard; revenue, appointment, patient-history and bill reports.

## Non-functional requirements
Responsive UI, parameterized SQL, layered backend architecture, validation, transaction support, useful error status codes, referential integrity and maintainable modules.

## Modules
- Patient Management
- Doctor and Department Management
- Appointment Management
- Hospital Service Management
- Billing
- Payments
- Reports/Dashboard

## ER diagram description
Department has many Doctors. Patient has many Appointments and Bills. Doctor has many Appointments. Appointment can have zero or one Bill. Bill has many BillItems and Payments. HospitalService has many BillItems.

## Relational schema
`department(department_id PK, department_name UQ, description)`

`patient(patient_id PK, full_name, date_of_birth, gender, phone UQ, email, address, created_at)`

`doctor(doctor_id PK, full_name, specialization, department_id FK, phone, consultation_fee, available_from, available_to)`

`appointment(appointment_id PK, patient_id FK, doctor_id FK, appointment_date, appointment_time, reason, status, created_at, UQ(doctor_id, appointment_date, appointment_time))`

`hospital_service(service_id PK, service_name UQ, description, price, active)`

`bill(bill_id PK, patient_id FK, appointment_id FK UQ nullable, bill_date, subtotal, tax, total_amount, status)`

`bill_item(bill_item_id PK, bill_id FK, service_id FK, quantity, unit_price, amount)`

`payment(payment_id PK, bill_id FK, payment_date, amount, payment_method, reference_no)`

## Normalization
The design separates departments, doctors, patients, services and transactions. Repeating groups such as multiple services on a bill are represented by `bill_item`. Many-to-one relationships use foreign keys. Bill totals are derived from item rows, reducing update anomalies. The schema is designed to satisfy 1NF and 2NF and avoids obvious transitive dependencies in the core master tables.

## DFD description
External entities are hospital staff/users. Inputs are patient, doctor, department, appointment, service and payment forms. The application sends validated requests through REST endpoints to service classes and parameterized repositories. MySQL stores master/transaction data and returns query results to the backend, which supplies JSON to the frontend.

## Use cases
Actor: Hospital staff. Use cases: manage patients, manage doctors/departments, book/cancel/complete appointments, manage services, create bills, add services, record payments, view reports.

## System architecture
Browser → Fetch API → Spring Boot Controller → Service Layer → JdbcTemplate Repository → MySQL. Cross-cutting exception handling and CORS sit at the web layer; Spring transactions protect multi-step operations.

## Database design features
- Composite unique key prevents duplicate doctor/date/time slots.
- Views provide appointment and bill summaries.
- Procedure returns patient appointment history.
- Bill-item triggers recalculate subtotal/tax/total.
- Payment triggers update bill payment status.
- Indexes support phone, department, patient/doctor appointment, appointment date, bill patient and payment bill lookups.

## API documentation
See README for endpoint list. Request DTOs are used for appointment, bill, bill-item, payment and status operations.

## Testing
Backend unit/integration test scaffolding is included under `backend/src/test`. Manual browser cases are listed in `TEST_CASES.md`.

## Conclusion
The project demonstrates how a relational DBMS can support a realistic hospital workflow while keeping business logic in a service layer and data integrity in both Java validation and MySQL constraints/triggers.

## Future enhancements
Production authentication/authorization, audit logging, appointment reminders, doctor calendars, insurance workflows, PDF invoices, pagination, database migrations, automated CI and deployment configuration.
