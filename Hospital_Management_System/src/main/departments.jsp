<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Departments" %>

<!DOCTYPE html>
<html>
<head>
    <title>Departments</title>
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
            margin-right:10px;
            text-decoration:none;
            font-weight:bold;
            color:#2563eb;
        }

        .empty {
            text-align:center;
            padding:20px;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>Departments</h2>
    <div>
        <a href="<%=request.getContextPath()%>/departments?action=new">
            <button>Add Department</button>
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
        <th>Department Name</th>
        <th>Description</th>
        <th>Actions</th>
    </tr>

<%
    List<Departments> departmentList =
            (List<Departments>) request.getAttribute("departmentList");

    if (departmentList != null && !departmentList.isEmpty()) {
        for (Departments d : departmentList) {
%>
    <tr>
        <td><%= d.getDepartment_id() %></td>
        <td><%= d.getDepartment_name() %></td>
        <td><%= d.getDescription() %></td>
        <td class="action-links">
            <a href="<%=request.getContextPath()%>/departments?action=edit&id=<%=d.getDepartment_id()%>">
                Edit
            </a>
            <a href="<%=request.getContextPath()%>/departments?action=delete&id=<%=d.getDepartment_id()%>"
               onclick="return confirm('Are you sure you want to delete this department?');">
                Delete
            </a>
        </td>
    </tr>
<%
        }
    } else {
%>
    <tr>
        <td colspan="4" class="empty">
            No departments found.
        </td>
    </tr>
<%
    }
%>

</table>

</body>
</html>
