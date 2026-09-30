# Hospital Appointment and Billing System

A complete BTech/DBMS mini project using Java 17, Spring Boot 3.x, Spring JDBC/JdbcTemplate, MySQL 8.x, HTML5, CSS3 and Vanilla JavaScript. The project demonstrates primary/foreign keys, constraints, indexes, views, stored procedures, triggers, transactions, REST APIs and reporting.

## Prerequisites
- JDK 17 or newer (project targets Java 17)
- Maven 3.9+
- MySQL 8.x
- A modern browser

## Folder structure
```text
Hospital-Appointment-Billing-System/
├── frontend/
├── backend/
├── database/
├── documentation/
└── README.md
```

## Database setup
1. Start MySQL.
2. Open a MySQL client: `mysql -u root -p`
3. Execute these files in order:
   - `source database/01_create_database.sql`
   - `source database/02_create_tables.sql`
   - `source database/03_constraints.sql`
   - `source database/04_insert_sample_data.sql`
   - `source database/05_views.sql`
   - `source database/06_indexes.sql`
   - `source database/07_procedures.sql`
   - `source database/08_triggers.sql`
   - `source database/09_sample_queries.sql` (optional examples; it only contains SELECT/CALL statements)

If your MySQL client is already in the project root, the same commands work with the paths above.

## Configure database password
Edit `backend/src/main/resources/application.properties` and replace `CHANGE_ME` with your local MySQL password. Do not commit a real password.

## Start backend
```bash
cd backend
mvn spring-boot:run
```
The API runs at `http://localhost:8080`.

## Start frontend
Because the frontend uses Fetch API, serve the `frontend` directory over HTTP rather than relying on `file://`.

Option A, Python:
```bash
cd frontend
python -m http.server 5500
```
Then open `http://localhost:5500/index.html`.

Option B, VS Code Live Server: open the `frontend` folder and start Live Server. The backend CORS configuration allows localhost development origins.

## Demo login
Login is an academic/demo screen only. It does not provide real authentication or authorization. Any non-empty username and password are accepted by the frontend and stored only in sessionStorage.

## API summary
- Patients: `GET/POST /api/patients`, `GET/PUT/DELETE /api/patients/{id}`
- Doctors: `GET/POST /api/doctors`, `GET/PUT/DELETE /api/doctors/{id}`
- Departments: `GET/POST /api/departments`, `PUT/DELETE /api/departments/{id}`
- Appointments: `GET/POST /api/appointments`, `GET/PUT/DELETE /api/appointments/{id}`, `PUT /api/appointments/{id}/status`
- Services: `GET/POST /api/services`, `PUT/DELETE /api/services/{id}`
- Bills: `GET /api/bills`, `GET /api/bills/{id}`, `POST /api/bills`, `POST /api/bills/{id}/items`, `DELETE /api/bills/{id}/items/{itemId}`
- Payments: `GET /api/bills/{billId}/payments`, `POST /api/bills/{billId}/payments`
- Dashboard: `GET /api/dashboard`
- Reports: `GET /api/reports/revenue`, `GET /api/reports/appointments`, `GET /api/reports/pending-bills`, `GET /api/reports/paid-bills`, `GET /api/reports/patient-history/{patientId}`

## DBMS concepts demonstrated
Relational design, normalization, PK/FK relationships, NOT NULL/UNIQUE/CHECK constraints, composite unique appointment-slot protection, indexes, views, stored procedures, triggers, transaction management, parameterized JDBC SQL, aggregation/report queries and referential integrity.

## Troubleshooting
- **Connection refused:** confirm MySQL is running and port 3306 is available.
- **Access denied:** verify `spring.datasource.username/password`.
- **Unknown database:** run the database scripts in the stated order.
- **CORS error:** serve frontend through localhost HTTP and keep backend on port 8080.
- **Duplicate appointment:** choose another doctor/date/time; the database has a unique constraint and the backend returns HTTP 409.
- **Payment rejected:** the payment cannot exceed the current outstanding balance.
