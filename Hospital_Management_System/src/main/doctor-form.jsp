<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Doctors" %>

<%
    Doctors doctor = (Doctors) request.getAttribute("doctor");
    boolean isEdit = (doctor != null);
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Edit Doctor" : "Add Doctor" %></title>
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
            width:450px;
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
            margin-top:15px;
            font-weight:bold;
        }

        input {
            width:100%;
            padding:8px;
            border:1px solid #ccc;
            border-radius:6px;
            margin-top:5px;
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

        .submit-btn { background:#2563eb; }
        .cancel-btn { background:#6b7280; }

    </style>
</head>
<body>

<div class="form-container">

    <h2><%= isEdit ? "Edit Doctor" : "Add Doctor" %></h2>

    <form method="post" action="<%=request.getContextPath()%>/doctors">

        <input type="hidden" name="action"
               value="<%= isEdit ? "update" : "insert" %>"/>

        <% if (isEdit) { %>
            <input type="hidden" name="doctor_id"
                   value="<%= doctor.getDoctor_id() %>"/>
        <% } %>

        <label>User ID</label>
        <input type="number" name="user_id"
               value="<%= isEdit ? doctor.getUser_id() : "" %>" required/>

        <label>Department ID</label>
        <input type="number" name="department_id"
               value="<%= isEdit ? doctor.getDepartment_id() : "" %>" required/>

        <label>Qualification</label>
        <input type="text" name="qualification"
               value="<%= isEdit ? doctor.getQualification() : "" %>" required/>

        <label>Experience (Years)</label>
        <input type="number" name="experience_years"
               value="<%= isEdit ? doctor.getExperience_years() : "" %>" required/>

        <label>Consultation Fee</label>
        <input type="number" step="0.01" name="consultation_fee"
               value="<%= isEdit ? doctor.getConsultation_fee() : "" %>" required/>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <div class="buttons">
            <button type="submit" class="submit-btn">
                <%= isEdit ? "Update" : "Save" %>
            </button>

            <a href="<%=request.getContextPath()%>/doctors">
                <button type="button" class="cancel-btn">Cancel</button>
            </a>
        </div>

    </form>

</div>

</body>
</html>
