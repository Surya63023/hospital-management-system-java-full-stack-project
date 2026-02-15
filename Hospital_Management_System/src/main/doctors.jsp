<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Doctors" %>

<!DOCTYPE html>
<html>
<head>
    <title>Doctors Management</title>
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

        .actions a {
            margin-right:10px;
            text-decoration:none;
            font-weight:bold;
            color:#2563eb;
        }

        .pagination {
            margin-top:20px;
        }

        .pagination a {
            margin-right:10px;
            text-decoration:none;
            color:#2563eb;
            font-weight:bold;
        }

        .empty {
            text-align:center;
            padding:20px;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>Doctors</h2>
    <div>
        <a href="<%=request.getContextPath()%>/doctors?action=new">
            <button>Add Doctor</button>
        </a>
        <a href="<%=request.getContextPath()%>/admin-dashboard">
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
        <th>User ID</th>
        <th>Department ID</th>
        <th>Qualification</th>
        <th>Experience (Years)</th>
        <th>Consultation Fee</th>
        <th>Actions</th>
    </tr>

<%
    List<Doctors> doctorList =
            (List<Doctors>) request.getAttribute("doctorList");

    if (doctorList != null && !doctorList.isEmpty()) {
        for (Doctors d : doctorList) {
%>
    <tr>
        <td><%= d.getDoctor_id() %></td>
        <td><%= d.getUser_id() %></td>
        <td><%= d.getDepartment_id() %></td>
        <td><%= d.getQualification() %></td>
        <td><%= d.getExperience_years() %></td>
        <td><%= d.getConsultation_fee() %></td>
        <td class="actions">
            <a href="<%=request.getContextPath()%>/doctors?action=edit&id=<%=d.getDoctor_id()%>">
                Edit
            </a>
            <a href="<%=request.getContextPath()%>/doctors?action=delete&id=<%=d.getDoctor_id()%>"
               onclick="return confirm('Are you sure you want to delete this doctor?');">
                Delete
            </a>
        </td>
    </tr>
<%
        }
    } else {
%>
    <tr>
        <td colspan="7" class="empty">
            No doctors found.
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
        <a href="<%=request.getContextPath()%>/doctors?page=<%=currentPage-1%>">
            Previous
        </a>
    <% } %>

    <span>Page <%=currentPage%></span>

    <a href="<%=request.getContextPath()%>/doctors?page=<%=currentPage+1%>">
        Next
    </a>
</div>
<%
    }
%>

</body>
</html>
