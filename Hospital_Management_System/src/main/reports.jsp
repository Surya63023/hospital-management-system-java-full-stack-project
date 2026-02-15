<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.MedicalReports" %>

<%
    String role = (String) session.getAttribute("role");
    List<MedicalReports> reportList =
            (List<MedicalReports>) request.getAttribute("reportList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Medical Reports</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:Arial; }

        body { background:#f4f6f9; padding:30px; }

        .header {
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:25px;
        }

        h2 { color:#1f2937; }

        .actions a { text-decoration:none; margin-left:10px; }

        .btn {
            padding:8px 14px;
            border:none;
            border-radius:6px;
            background:#2563eb;
            color:white;
            cursor:pointer;
            font-size:14px;
        }

        .btn:hover { opacity:0.9; }

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

        th { background:#1f2937; color:white; }

        tr:hover { background:#f1f5f9; }

        .file-link {
            color:#2563eb;
            font-weight:bold;
            text-decoration:none;
        }

        .file-link:hover { text-decoration:underline; }
    </style>
</head>
<body>

<div class="header">
    <h2>Medical Reports</h2>

    <div class="actions">

        <% if ("DOCTOR".equalsIgnoreCase(role)) { %>
            <a href="<%=request.getContextPath()%>/reports?action=upload">
                <button class="btn">Upload Report</button>
            </a>
        <% } %>

        <% if ("ADMIN".equalsIgnoreCase(role)) { %>
            <a href="<%=request.getContextPath()%>/admin-dashboard">
                <button class="btn">Dashboard</button>
            </a>
        <% } else if ("PATIENT".equalsIgnoreCase(role)) { %>
            <a href="<%=request.getContextPath()%>/patient-dashboard">
                <button class="btn">Dashboard</button>
            </a>
        <% } else if ("DOCTOR".equalsIgnoreCase(role)) { %>
            <a href="<%=request.getContextPath()%>/doctor-dashboard">
                <button class="btn">Dashboard</button>
            </a>
        <% } %>

        <a href="<%=request.getContextPath()%>/logout">
            <button class="btn">Logout</button>
        </a>
    </div>
</div>

<table>
<tr>
    <th>ID</th>
    <th>Patient ID</th>
    <th>Report Type</th>
    <th>Description</th>
    <th>Date</th>
    <th>File</th>
</tr>

<%
    if (reportList != null && !reportList.isEmpty()) {
        for (MedicalReports r : reportList) {
%>
<tr>
    <td><%= r.getReport_id() %></td>
    <td><%= r.getPatient_id() %></td>
    <td><%= r.getReport_type() %></td>
    <td><%= r.getReport_description() %></td>
    <td><%= r.getReport_date() %></td>
    <td>
        <a class="file-link"
           href="<%=request.getContextPath()%>/<%=r.getFile_path()%>"
           target="_blank">
            View File
        </a>
    </td>
</tr>
<%
        }
    } else {
%>
<tr>
    <td colspan="6" style="text-align:center;">
        No reports found.
    </td>
</tr>
<%
    }
%>

</table>

</body>
</html>
