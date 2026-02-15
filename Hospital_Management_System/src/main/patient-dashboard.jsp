<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Patients" %>
<%@ page import="com.hospital.model.Appointments" %>
<%@ page import="com.hospital.model.Users" %>


<%
    Patients patient = (Patients) request.getAttribute("patient");
    List<Appointments> appointments =
            (List<Appointments>) request.getAttribute("appointments");
%>

<%
    Users loggedUser = (Users) session.getAttribute("loggedUser");
    String patientName = (loggedUser != null) ? loggedUser.getName() : "Patient";
%>


<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Arial, Helvetica, sans-serif;
        }

        body {
            display:flex;
            background:#f4f6f9;
            min-height:100vh;
        }

        /* Sidebar */
        .sidebar {
            width:240px;
            background:#1f2937;
            color:#fff;
            padding:20px;
            min-height:100vh;
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
            color:#fff;
            border-radius:6px;
            transition:0.3s;
        }

        .sidebar a:hover {
            background:#374151;
        }

        /* Main Content */
        .main {
            flex:1;
            padding:25px;
        }

        .welcome {
            margin-bottom:25px;
        }

        .welcome h2 {
            color:#1f2937;
            margin-bottom:5px;
        }

        .cards {
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap:20px;
            margin-bottom:30px;
        }

        .card {
            background:#fff;
            padding:20px;
            border-radius:10px;
            box-shadow:0 5px 15px rgba(0,0,0,0.1);
            transition:0.3s;
        }

        .card:hover {
            transform:translateY(-5px);
        }

        .card h3 {
            margin-bottom:10px;
            color:#555;
        }

        .card p {
            font-weight:bold;
            color:#1f2937;
        }

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

        tr:hover {
            background:#f1f5f9;
        }

        @media(max-width:768px){
            body {
                flex-direction:column;
            }

            .sidebar {
                width:100%;
                min-height:auto;
            }
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>Patient Panel</h2>
    <a href="<%=request.getContextPath()%>/patient-dashboard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/appointments">My Appointments</a>
    <a href="<%=request.getContextPath()%>/reports">My Reports</a>
    <a href="<%=request.getContextPath()%>/logout">Logout</a>
</div>

<div class="main">

    <div class="welcome">
        <h2>
    Welcome, <%= patientName %>
</h2>

        <p>Your health overview</p>
    </div>

    <div class="cards">
    <div class="card">
    <h3>Name</h3>
    <p><%= patientName %></p>
</div>
    
        <div class="card">
            <h3>Date of Birth</h3>
            <p><%= (patient != null) ? patient.getDate_of_birth() : "N/A" %></p>
        </div>

        <div class="card">
            <h3>Gender</h3>
            <p><%= (patient != null) ? patient.getGender() : "N/A" %></p>
        </div>

        <div class="card">
            <h3>Blood Group</h3>
            <p><%= (patient != null) ? patient.getBlood_group() : "N/A" %></p>
        </div>

        <div class="card">
            <h3>Total Appointments</h3>
            <p><%= (appointments != null) ? appointments.size() : 0 %></p>
        </div>
    </div>

    <h2>Recent Appointments</h2>
    <br>

    <table>
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
        </tr>

        <%
            if (appointments != null && !appointments.isEmpty()) {
                for (Appointments a : appointments) {
        %>
        <tr>
            <td><%= a.getAppointment_id() %></td>
            <td><%= a.getAppointment_date() %></td>
            <td><%= a.getAppointment_time() %></td>
            <td><%= a.getStatus() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4">No appointments found.</td>
        </tr>
        <%
            }
        %>

    </table>

</div>

</body>
</html>
