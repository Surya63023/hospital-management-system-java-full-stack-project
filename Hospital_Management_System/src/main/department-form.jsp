<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Departments" %>

<%
    Departments department = (Departments) request.getAttribute("department");
    boolean isEdit = (department != null);
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Edit Department" : "Add Department" %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:Arial; }

        body {
            background:#f4f6f9;
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
        }

        .form-container {
            background:white;
            padding:30px;
            width:400px;
            border-radius:10px;
            box-shadow:0 5px 15px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom:20px;
            text-align:center;
            color:#1f2937;
        }

        label {
            display:block;
            margin-bottom:5px;
            font-weight:bold;
            margin-top:15px;
        }

        input, textarea {
            width:100%;
            padding:8px;
            border:1px solid #ccc;
            border-radius:6px;
        }

        textarea {
            resize:none;
            height:80px;
        }

        .error {
            color:red;
            margin-top:10px;
            text-align:center;
        }

        .buttons {
            margin-top:20px;
            display:flex;
            justify-content:space-between;
        }

        button {
            padding:8px 14px;
            border:none;
            border-radius:6px;
            cursor:pointer;
            color:white;
        }

        .submit-btn {
            background:#2563eb;
        }

        .submit-btn:hover {
            background:#1d4ed8;
        }

        .cancel-btn {
            background:#6b7280;
        }

        .cancel-btn:hover {
            background:#4b5563;
        }
    </style>
</head>
<body>

<div class="form-container">

    <h2><%= isEdit ? "Edit Department" : "Add Department" %></h2>

    <form method="post" action="<%=request.getContextPath()%>/departments">

        <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>"/>

        <% if (isEdit) { %>
            <input type="hidden" name="department_id"
                   value="<%= department.getDepartment_id() %>"/>
        <% } %>

        <label>Department Name</label>
        <input type="text" name="department_name"
               value="<%= isEdit ? department.getDepartment_name() : "" %>" required/>

        <label>Description</label>
        <textarea name="description"><%= isEdit ? department.getDescription() : "" %></textarea>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <div class="buttons">
            <button type="submit" class="submit-btn">
                <%= isEdit ? "Update" : "Save" %>
            </button>

            <a href="<%=request.getContextPath()%>/departments">
                <button type="button" class="cancel-btn">Cancel</button>
            </a>
        </div>

    </form>

</div>

</body>
</html>
