<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Patients" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
    <title>Patient Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:Arial; }

        body {
            background:#f4f6f9;
            display:flex;
            justify-content:center;
            align-items:center;
            min-height:100vh;
        }

        .card {
            background:white;
            padding:30px;
            border-radius:12px;
            box-shadow:0 10px 25px rgba(0,0,0,0.1);
            width:100%;
            max-width:500px;
        }

        h2 {
            text-align:center;
            margin-bottom:20px;
            color:#1f2937;
        }

        .form-group {
            margin-bottom:15px;
        }

        label {
            font-weight:bold;
            font-size:14px;
        }

        input, select {
            width:100%;
            padding:10px;
            margin-top:6px;
            border-radius:6px;
            border:1px solid #ccc;
        }

        button {
            width:100%;
            padding:10px;
            border:none;
            border-radius:6px;
            background:#2563eb;
            color:white;
            font-weight:bold;
            cursor:pointer;
            margin-top:10px;
        }

        button:hover {
            background:#1d4ed8;
        }

        .readonly-field {
            background:#f1f5f9;
        }

        .top-actions {
            text-align:center;
            margin-bottom:15px;
        }

        .top-actions a {
            text-decoration:none;
            color:#2563eb;
            font-weight:bold;
            margin-right:15px;
        }
    </style>
</head>
<body>

<%
    Patients patient = (Patients) request.getAttribute("patient");

    String dobValue = "";
    String genderValue = "";
    String bloodGroupValue = "";

    if (patient != null) {
        if (patient.getDate_of_birth() != null) {
            dobValue = patient.getDate_of_birth().toString();
        }
        if (patient.getGender() != null) {
            genderValue = patient.getGender();
        }
        if (patient.getBlood_group() != null) {
            bloodGroupValue = patient.getBlood_group();
        }
    }
%>

<div class="card">

    <div class="top-actions">
        <a href="<%=request.getContextPath()%>/appointments">My Appointments</a>
        <a href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>

    <h2>My Profile</h2>

    <form method="post"
          action="<%=request.getContextPath()%>/patients">

        <input type="hidden" name="action" value="update">

        <div class="form-group">
            <label>Date of Birth</label>
            <input type="date"
                   name="date_of_birth"
                   value="<%=dobValue%>"
                   required>
        </div>

        <div class="form-group">
            <label>Gender</label>
            <select name="gender" required>
                <option value="MALE"
                    <%= "MALE".equalsIgnoreCase(genderValue) ? "selected" : "" %>>
                    MALE
                </option>
                <option value="FEMALE"
                    <%= "FEMALE".equalsIgnoreCase(genderValue) ? "selected" : "" %>>
                    FEMALE
                </option>
                <option value="OTHER"
                    <%= "OTHER".equalsIgnoreCase(genderValue) ? "selected" : "" %>>
                    OTHER
                </option>
            </select>
        </div>

        <div class="form-group">
            <label>Blood Group</label>
            <select name="blood_group" required>
                <%
                    String[] groups = {
                        "A+", "A-", "B+", "B-",
                        "AB+", "AB-", "O+", "O-"
                    };

                    for (String group : groups) {
                %>
                <option value="<%=group%>"
                    <%= group.equalsIgnoreCase(bloodGroupValue) ? "selected" : "" %>>
                    <%=group%>
                </option>
                <%
                    }
                %>
            </select>
        </div>

        <button type="submit">Update Profile</button>

    </form>

</div>

</body>
</html>
