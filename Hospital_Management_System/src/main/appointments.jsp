<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Appointments" %>

<!DOCTYPE html>
<html>
<head>
    <title>Appointments</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:Arial; }

        body {
            background:#f4f6f9;
            padding:20px;
        }

        .header {
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:20px;
        }

        h2 { color:#1f2937; }

        button {
            padding:8px 14px;
            border:none;
            border-radius:6px;
            background:#2563eb;
            color:white;
            cursor:pointer;
        }

        button:hover { background:#1d4ed8; }

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
            border-bottom:1px solid #eee;
            font-size:14px;
            text-align:left;
        }

        th {
            background:#1f2937;
            color:white;
        }

        tr:hover { background:#f1f5f9; }

        .action-links a {
            margin-right:8px;
            text-decoration:none;
            color:#2563eb;
            font-weight:bold;
        }

        .pagination {
            margin-top:20px;
        }

        .pagination a {
            margin-right:10px;
            text-decoration:none;
            color:#2563eb;
        }
    </style>
</head>
<body>

<%
    String role = (String) session.getAttribute("role");

    String dashboardUrl = request.getContextPath() + "/login";

    if ("ADMIN".equalsIgnoreCase(role)) {
        dashboardUrl = request.getContextPath() + "/admin-dashboard";
    } else if ("PATIENT".equalsIgnoreCase(role)) {
        dashboardUrl = request.getContextPath() + "/patient-dashboard";
    } else if ("DOCTOR".equalsIgnoreCase(role)) {
        dashboardUrl = request.getContextPath() + "/doctor-dashboard";
    }
%>

<div class="header">
    <h2>Appointments</h2>

    <div>

        <%-- Only PATIENT can create appointment --%>
        <% if ("PATIENT".equalsIgnoreCase(role)) { %>
            <a href="<%=request.getContextPath()%>/appointments?action=new">
                <button>New Appointment</button>
            </a>
        <% } %>

        <a href="<%=dashboardUrl%>">
            <button>Dashboard</button>
        </a>

        <a href="<%=request.getContextPath()%>/logout">
            <button>Logout</button>
        </a>
    </div>
</div>


<table>
    <tr>
        <th>ID</th>
        <th>Patient ID</th>
        <th>Doctor ID</th>
        <th>Date</th>
        <th>Time</th>
        <th>Reason</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>

<%
    List<Appointments> appointmentList =
            (List<Appointments>) request.getAttribute("appointmentList");

    if (appointmentList != null && !appointmentList.isEmpty()) {
        for (Appointments a : appointmentList) {
%>
    <tr>
        <td><%= a.getAppointment_id() %></td>
        <td><%= a.getPatient_id() %></td>
        <td><%= a.getDoctor_id() %></td>
        <td><%= a.getAppointment_date() %></td>
        <td><%= a.getAppointment_time() %></td>
        <td><%= a.getReason() %></td>
        <td><%= a.getStatus() %></td>

        <td class="action-links">

            <% if ("ADMIN".equalsIgnoreCase(role)) { %>
                <a href="<%=request.getContextPath()%>/appointments?action=edit&id=<%=a.getAppointment_id()%>">
                    Edit
                </a>
            <% } %>

            <% if ("SCHEDULED".equalsIgnoreCase(a.getStatus())) { %>

                <form method="post"
                      action="<%=request.getContextPath()%>/appointments"
                      style="display:inline;">

                    <input type="hidden" name="action" value="status">
                    <input type="hidden" name="appointment_id"
                           value="<%=a.getAppointment_id()%>">

                    <select name="status">
                        <% if ("PATIENT".equalsIgnoreCase(role)) { %>
                            <option value="CANCELLED">CANCELLED</option>
                        <% } else { %>
                            <option value="COMPLETED">COMPLETED</option>
                            <option value="CANCELLED">CANCELLED</option>
                        <% } %>
                    </select>

                    <button type="submit">Update</button>
                </form>

            <% } %>

        </td>
    </tr>
<%
        }
    } else {
%>
    <tr>
        <td colspan="8" style="text-align:center;">
            No appointments found.
        </td>
    </tr>
<%
    }
%>
</table>

<%
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    if (currentPage != null) {
%>
<div class="pagination">
    <% if (currentPage > 1) { %>
        <a href="<%=request.getContextPath()%>/appointments?page=<%=currentPage-1%>">
            Previous
        </a>
    <% } %>

    <span>Page <%=currentPage%></span>

    <a href="<%=request.getContextPath()%>/appointments?page=<%=currentPage+1%>">
        Next
    </a>
</div>
<%
    }
%>

</body>
</html>
