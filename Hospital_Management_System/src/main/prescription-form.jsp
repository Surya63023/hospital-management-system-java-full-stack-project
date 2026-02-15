<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Prescriptions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Prescription Form</title>
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
            max-width:600px;
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

        input, textarea {
            width:100%;
            padding:10px;
            margin-top:6px;
            border-radius:6px;
            border:1px solid #ccc;
        }

        textarea {
            resize:vertical;
            min-height:80px;
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
    Prescriptions prescription =
            (Prescriptions) request.getAttribute("prescription");

    boolean isEdit = (prescription != null);

    String diagnosisValue = "";
    String medicinesValue = "";
    String instructionsValue = "";

    if (isEdit) {
        if (prescription.getDiagnosis() != null)
            diagnosisValue = prescription.getDiagnosis();

        if (prescription.getMedicines() != null)
            medicinesValue = prescription.getMedicines();

        if (prescription.getInstructions() != null)
            instructionsValue = prescription.getInstructions();
    }
%>

<div class="card">

    <div class="top-actions">
        <a href="<%=request.getContextPath()%>/doctor-appointments">
            Back to Appointments
        </a>
        <a href="<%=request.getContextPath()%>/logout">
            Logout
        </a>
    </div>

    <h2><%= isEdit ? "Edit Prescription" : "Create Prescription" %></h2>

    <form method="post"
          action="<%=request.getContextPath()%>/prescriptions">

        <input type="hidden"
               name="action"
               value="<%= isEdit ? "update" : "insert" %>">

        <% if (isEdit) { %>
            <input type="hidden"
                   name="prescription_id"
                   value="<%= prescription.getPrescription_id() %>">
        <% } else { %>
            <!-- Required for insert -->
            <div class="form-group">
                <label>Appointment ID</label>
                <input type="number"
                       name="appointment_id"
                       required>
            </div>
        <% } %>

        <div class="form-group">
            <label>Diagnosis</label>
            <textarea name="diagnosis" required><%= diagnosisValue %></textarea>
        </div>

        <div class="form-group">
            <label>Medicines</label>
            <textarea name="medicines" required><%= medicinesValue %></textarea>
        </div>

        <div class="form-group">
            <label>Instructions</label>
            <textarea name="instructions"><%= instructionsValue %></textarea>
        </div>

        <button type="submit">
            <%= isEdit ? "Update Prescription" : "Save Prescription" %>
        </button>

    </form>

</div>

</body>
</html>
