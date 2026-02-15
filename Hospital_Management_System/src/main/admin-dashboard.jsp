<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Appointments" %>
<%@ page import="com.hospital.model.Prescriptions" %>
<%@ page import="com.hospital.model.MedicalReports" %>
<%@ page import="com.hospital.model.Users" %>

<%
    Users loggedUser = (Users) session.getAttribute("loggedUser");
    String adminName = (loggedUser != null) ? loggedUser.getName() : "Admin";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:Arial; }

        body { background:#f4f6f9; display:flex; }

        .sidebar {
            width:240px;
            background:#1f2937;
            color:#fff;
            min-height:100vh;
            padding:20px;
        }

        .sidebar h2 { margin-bottom:30px; text-align:center; }

        .sidebar a {
            display:block;
            padding:12px;
            margin-bottom:10px;
            text-decoration:none;
            color:#fff;
            border-radius:6px;
            transition:0.3s;
        }

        .sidebar a:hover { background:#374151; }

        .main { flex:1; padding:25px; }

        /* Welcome Card */
        .welcome-card {
            background:#fff;
            padding:20px;
            border-radius:10px;
            box-shadow:0 5px 15px rgba(0,0,0,0.1);
            margin-bottom:25px;
        }

        .welcome-card h2 {
            margin-bottom:5px;
            color:#1f2937;
        }

        .welcome-card p { color:#555; }

        .cards {
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap:20px;
            margin-bottom:30px;
        }

        .card {
            background:#fff;
            padding:20px;
            border-radius:10px;
            box-shadow:0 5px 15px rgba(0,0,0,0.1);
            text-align:center;
            transition:0.3s;
        }

        .card:hover { transform:translateY(-5px); }

        .card h3 { margin-bottom:10px; color:#555; }

        .card p {
            font-size:22px;
            font-weight:bold;
            color:#1f2937;
        }

        .section { margin-bottom:40px; }

        table {
            width:100%;
            border-collapse:collapse;
            background:#fff;
            border-radius:10px;
            overflow:hidden;
            box-shadow:0 5px 15px rgba(0,0,0,0.1);
        }

        th, td {
            padding:12px;
            text-align:left;
            border-bottom:1px solid #eee;
            font-size:14px;
        }

        th {
            background:#1f2937;
            color:#fff;
        }

        tr:hover { background:#f1f5f9; }

        @media(max-width:768px){
            body { flex-direction:column; }
            .sidebar { width:100%; min-height:auto; }
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>Admin Panel</h2>
    <a href="<%=request.getContextPath()%>/admin-dashboard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/departments">Departments</a>
    <a href="<%=request.getContextPath()%>/doctors">Doctors</a>
    <a href="<%=request.getContextPath()%>/appointments">Appointments</a>
    <a href="<%=request.getContextPath()%>/reports">Reports</a>
    <a href="<%=request.getContextPath()%>/logout">Logout</a>
</div>

<div class="main">

    <!-- Welcome Section -->
    <div class="welcome-card">
        <h2>Welcome, <%= adminName %></h2>
        <p>Administrator Dashboard Overview</p>
    </div>

    <!-- STAT CARDS -->
    <div class="cards">
        <div class="card">
            <h3>Total Users</h3>
            <p><%= request.getAttribute("totalUsers") %></p>
        </div>

        <div class="card">
            <h3>Total Doctors</h3>
            <p><%= request.getAttribute("totalDoctors") %></p>
        </div>

        <div class="card">
            <h3>Total Patients</h3>
            <p><%= request.getAttribute("totalPatients") %></p>
        </div>

        <div class="card">
            <h3>Total Departments</h3>
            <p><%= request.getAttribute("totalDepartments") %></p>
        </div>

        <div class="card">
            <h3>Total Appointments</h3>
            <p><%= request.getAttribute("totalAppointments") %></p>
        </div>

        <div class="card">
            <h3>Total Prescriptions</h3>
            <p><%= request.getAttribute("totalPrescriptions") %></p>
        </div>

        <div class="card">
            <h3>Total Reports</h3>
            <p><%= request.getAttribute("totalReports") %></p>
        </div>
    </div>


    <!-- RECENT APPOINTMENTS -->
    <div class="section">
        <h2>Recent Appointments</h2>
        <br>
        <table>
            <tr>
                <th>ID</th>
                <th>Patient</th>
                <th>Doctor</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
            </tr>
            <%
                List<Appointments> recentAppointments =
                        (List<Appointments>) request.getAttribute("recentAppointments");

                if (recentAppointments != null) {
                    for (Appointments a : recentAppointments) {
            %>
            <tr>
                <td><%= a.getAppointment_id() %></td>
                <td><%= a.getPatient_id() %></td>
                <td><%= a.getDoctor_id() %></td>
                <td><%= a.getAppointment_date() %></td>
                <td><%= a.getAppointment_time() %></td>
                <td><%= a.getStatus() %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>

    <!-- RECENT PRESCRIPTIONS -->
    <div class="section">
        <h2>Recent Prescriptions</h2>
        <br>
        <table>
            <tr>
                <th>ID</th>
                <th>Appointment</th>
                <th>Diagnosis</th>
                <th>Issued At</th>
            </tr>
            <%
                List<Prescriptions> recentPrescriptions =
                        (List<Prescriptions>) request.getAttribute("recentPrescriptions");

                if (recentPrescriptions != null) {
                    for (Prescriptions p : recentPrescriptions) {
            %>
            <tr>
                <td><%= p.getPrescription_id() %></td>
                <td><%= p.getAppointment_id() %></td>
                <td><%= p.getDiagnosis() %></td>
                <td><%= p.getIssued_at() %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>

    <!-- RECENT REPORTS -->
    <div class="section">
        <h2>Recent Medical Reports</h2>
        <br>
        <table>
            <tr>
                <th>ID</th>
                <th>Patient</th>
                <th>Type</th>
                <th>Date</th>
            </tr>
            <%
                List<MedicalReports> recentReports =
                        (List<MedicalReports>) request.getAttribute("recentReports");

                if (recentReports != null) {
                    for (MedicalReports r : recentReports) {
            %>
            <tr>
                <td><%= r.getReport_id() %></td>
                <td><%= r.getPatient_id() %></td>
                <td><%= r.getReport_type() %></td>
                <td><%= r.getReport_date() %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>

</div>

</body>
</html>
