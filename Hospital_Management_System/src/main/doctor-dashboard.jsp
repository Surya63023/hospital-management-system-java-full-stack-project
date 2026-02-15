<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Appointments" %>
<%@ page import="com.hospital.model.Doctors" %>
<%@ page import="com.hospital.model.Users" %>

<%
    Users user = (Users) session.getAttribute("loggedUser");
    Doctors doctor = (Doctors) request.getAttribute("doctor");

    List<Appointments> appointmentList =
            (List<Appointments>) request.getAttribute("appointments");

    Integer totalAppointments =
            (Integer) request.getAttribute("totalAppointments");

    if (totalAppointments == null && appointmentList != null) {
        totalAppointments = appointmentList.size();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:Arial; }

        body {
            display:flex;
            background:#f4f6f9;
        }

        /* Sidebar */
        .sidebar {
            width:240px;
            background:#1f2937;
            color:white;
            min-height:100vh;
            padding:20px;
        }

        .sidebar h2 {
            text-align:center;
            margin-bottom:30px;
        }

        .sidebar a {
            display:block;
            padding:12px;
            margin-bottom:10px;
            text-decoration:none;
            color:white;
            border-radius:6px;
            transition:0.3s;
        }

        .sidebar a:hover {
            background:#374151;
        }

        /* Main */
        .main {
            flex:1;
            padding:25px;
        }

        .welcome-card {
            background:white;
            padding:20px;
            border-radius:10px;
            box-shadow:0 5px 15px rgba(0,0,0,0.1);
            margin-bottom:25px;
        }

        .welcome-card h2 {
            margin-bottom:8px;
            color:#1f2937;
        }

        .welcome-card p {
            color:#555;
            margin-bottom:4px;
        }

        .stats {
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap:20px;
            margin-bottom:30px;
        }

        .card {
            background:white;
            padding:20px;
            border-radius:10px;
            box-shadow:0 5px 15px rgba(0,0,0,0.1);
            text-align:center;
        }

        .card h3 {
            margin-bottom:10px;
            color:#555;
        }

        .card p {
            font-size:22px;
            font-weight:bold;
            color:#1f2937;
        }

        table {
            width:100%;
            border-collapse:collapse;
            background:white;
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
            color:white;
        }

        tr:hover {
            background:#f1f5f9;
        }

        .status {
            font-weight:bold;
        }

        .completed { color:green; }
        .scheduled { color:orange; }
        .cancelled { color:red; }

        @media(max-width:768px){
            body { flex-direction:column; }
            .sidebar { width:100%; min-height:auto; }
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>Doctor Panel</h2>
    <a href="<%=request.getContextPath()%>/doctor-dashboard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/doctor-appointments">Appointments</a>
    <a href="<%=request.getContextPath()%>/logout">Logout</a>
</div>

<div class="main">

    <!-- Welcome Card -->
    <div class="welcome-card">
        <h2>Welcome, Dr. <%= user != null ? user.getName() : "" %></h2>

        <p>
            <strong>Qualification:</strong>
            <%= doctor != null ? doctor.getQualification() : "-" %>
        </p>

        <p>
            <strong>Experience:</strong>
            <%= doctor != null ? doctor.getExperience_years() : "-" %> years
        </p>

        <p>
            <strong>Consultation Fee:</strong>
            ₹ <%= doctor != null ? doctor.getConsultation_fee() : "-" %>
        </p>
    </div>

    <!-- Stats -->
    <div class="stats">
        <div class="card">
            <h3>Total Appointments</h3>
            <p><%= totalAppointments != null ? totalAppointments : 0 %></p>
        </div>
    </div>

    <!-- Recent Appointments -->
    <h2 style="margin-bottom:15px;">Recent Appointments</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Patient ID</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
        </tr>

        <%
            if (appointmentList != null && !appointmentList.isEmpty()) {
                for (Appointments a : appointmentList) {

                    String statusClass = "";
                    if ("COMPLETED".equalsIgnoreCase(a.getStatus()))
                        statusClass = "completed";
                    else if ("SCHEDULED".equalsIgnoreCase(a.getStatus()))
                        statusClass = "scheduled";
                    else if ("CANCELLED".equalsIgnoreCase(a.getStatus()))
                        statusClass = "cancelled";
        %>
        <tr>
            <td><%= a.getAppointment_id() %></td>
            <td><%= a.getPatient_id() %></td>
            <td><%= a.getAppointment_date() %></td>
            <td><%= a.getAppointment_time() %></td>
            <td class="status <%=statusClass%>">
                <%= a.getStatus() %>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5" style="text-align:center;">
                No appointments found.
            </td>
        </tr>
        <%
            }
        %>
    </table>

</div>

</body>
</html>
