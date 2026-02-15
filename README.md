# 🏥 Hospital Management System (HMS)

Enterprise-grade role-based hospital management system for streamlined clinical, administrative, and operational workflows.

---

## 📌 Problem Statement

Hospitals require centralized control over patient records, doctor management, department administration, appointment scheduling, prescriptions, and audit tracking.

Manual or loosely connected systems introduce inefficiencies, security risks, and poor traceability.  
This system provides a structured, secure, database-driven solution to manage multi-role healthcare operations within a unified platform.

---

## 👥 Target Users

### 🔐 Admin
- Manage Doctors, Patients, Departments
- Monitor Appointments
- View Audit Logs
- Access system-wide data

### 🩺 Doctor
- View assigned appointments
- Manage patient records
- Add prescriptions and medical entries

### 🧑‍⚕️ Patient
- Access dashboard
- View appointments
- Access prescriptions and medical reports

---

## 🛠 Technology Stack

- Java 11+
- Jakarta Servlet 6.0 (Jakarta EE 10)
- JSP (Server-Side Rendering)
- JDBC
- MySQL 8.x
- Apache Tomcat 10+
- mysql-connector-j-9.1.0

---

## 🏗 Architecture

### Architecture Style
- Layered Architecture
- MVC Pattern
- DAO Pattern
- Monolithic Deployment

### Layer Breakdown

Presentation Layer → JSP  
Controller Layer → Servlets  
Business Logic → Embedded in Servlets  
Data Access Layer → DAO + DAOImpl  
Model Layer → POJOs  
Security Layer → Filters (AuthFilter, RoleFilter)

### Request Flow

Client → Servlet → DAO → Database → JSP Response

---

## 📦 Major Modules

### Authentication
- LoginServlet
- LogoutServlet
- Session-based authentication
- Role-based filtering

### User Management
- Users entity
- Role control

### Doctor Management
- CRUD operations

### Patient Management
- CRUD operations

### Department Management
- CRUD operations

### Appointment Management
- Book appointments
- Doctor-specific appointment mapping

### Prescription Management
- Prescription entity
- DAO-based persistence

### Medical Reports
- MedicalReports entity
- Database-driven storage

### Admin Dashboard
- System-wide overview

### Audit Logging
- Tracks system-level actions

---

## 🔒 Security Features

- Session-based authentication
- Role-based authorization
- AuthFilter for login validation
- RoleFilter for endpoint-level protection
- Role-restricted dashboards

---

## 📁 Project Structure

Hospital_Management_System/
│
├── src/
│ └── main/
│ ├── java/
│ │ └── com/
│ │ └── hospital/
│ │ ├── dao/
│ │ │ ├── AppointmentsDAO.java
│ │ │ ├── AuditLogsDAO.java
│ │ │ ├── DepartmentsDAO.java
│ │ │ ├── DoctorsDAO.java
│ │ │ ├── MedicalReportsDAO.java
│ │ │ ├── PatientsDAO.java
│ │ │ ├── PrescriptionsDAO.java
│ │ │ └── UsersDAO.java
│ │ │
│ │ ├── daoimpl/
│ │ │ ├── AppointmentsDAOImpl.java
│ │ │ ├── AuditLogsDAOImpl.java
│ │ │ ├── DepartmentsDAOImpl.java
│ │ │ ├── DoctorsDAOImpl.java
│ │ │ ├── MedicalReportsDAOImpl.java
│ │ │ ├── PatientsDAOImpl.java
│ │ │ ├── PrescriptionsDAOImpl.java
│ │ │ └── UsersDAOImpl.java
│ │ │
│ │ ├── model/
│ │ │ ├── Appointments.java
│ │ │ ├── AuditLogs.java
│ │ │ ├── Departments.java
│ │ │ ├── Doctors.java
│ │ │ ├── MedicalReports.java
│ │ │ ├── Patients.java
│ │ │ ├── Prescriptions.java
│ │ │ └── Users.java
│ │ │
│ │ ├── servlet/
│ │ │ ├── AdminDashboardServlet.java
│ │ │ ├── AppointmentsServlet.java
│ │ │ ├── DepartmentsServlet.java
│ │ │ ├── DoctorAppointmentsServlet.java
│ │ │ ├── DoctorDashboardServlet.java
│ │ │ ├── DoctorsServlet.java
│ │ │ ├── LoginServlet.java
│ │ │ ├── LogoutServlet.java
│ │ │ ├── PatientDashboardServlet.java
│ │ │ ├── PatientsServlet.java
│ │ │ ├── PrescriptionsServlet.java
│ │ │ ├── RegisterServlet.java
│ │ │ └── ReportUploadServlet.java
│ │ │
│ │ ├── filter/
│ │ │ ├── AuthFilter.java
│ │ │ └── RoleFilter.java
│ │ │
│ │ └── util/
│ │ └── DBConnection.java
│ │
│ └── webapp/
│ ├── META-INF/
│ ├── WEB-INF/
│ │ ├── lib/
│ │ │ └── mysql-connector-j-9.1.0.jar
│ │ └── web.xml
│ │
│ ├── admin-dashboard.jsp
│ ├── appointment-form.jsp
│ ├── appointments.jsp
│ ├── department-form.jsp
│ ├── departments.jsp
│ ├── doctor-dashboard.jsp
│ ├── doctor-appointments.jsp
│ ├── doctor-form.jsp
│ ├── doctors.jsp
│ ├── error.jsp
│ ├── login.jsp
│ ├── patient-dashboard.jsp
│ ├── patient-profile.jsp
│ ├── prescription-form.jsp
│ ├── register.jsp
│ ├── report-form.jsp
│ └── reports.jsp
│
├── database/ 
│ └── hospital_schema.sql
│
├── screenshots/
│ ├── login.png
│ ├── admin-dashboard.png
│ ├── doctor-dashboard.png
│ ├── patient-dashboard.png
│ └── reports.png
│
└── README.md

---

## 🗄 Database

Database: MySQL 8.x  
Connection: JDBC  
Utility Class: DBConnection.java  

Future database scripts will be stored in:

database/
└── hospital_schema.sql


---

## ⚠ Current Limitations

- No pagination implementation
- No PDF/export report generation
- No physical file storage for reports
- Direct JDBC (No ORM framework)

---

## 📈 Future Enhancements

- Pagination support
- File upload for reports
- PDF report export
- Spring Boot migration
- REST API layer
- Docker containerization
- CI/CD integration
- Unit & Integration testing

---

## 📄 License

Educational and portfolio demonstration project.

## 📁 Project Structure

