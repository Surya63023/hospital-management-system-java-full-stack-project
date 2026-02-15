<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Appointments" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>

<!DOCTYPE html>
<html>
<head>
    <title>Appointment Form</title>
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

        input, textarea, select {
            width:100%;
            padding:10px;
            margin-top:6px;
            border-radius:6px;
            border:1px solid #ccc;
        }

        textarea {
            resize:vertical;
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
    Appointments appointment = (Appointments) request.getAttribute("appointment");

    boolean isEdit = (appointment != null);

    String doctorId = "";
    String patientId = "";
    String dateValue = "";
    String timeValue = "";
    String reasonValue = "";
    String statusValue = "SCHEDULED";

    if (isEdit) {
        if (appointment.getDoctor_id() != null)
            doctorId = appointment.getDoctor_id().toString();

        if (appointment.getPatient_id() != null)
            patientId = appointment.getPatient_id().toString();

        if (appointment.getAppointment_date() != null)
            dateValue = appointment.getAppointment_date().toString();

        if (appointment.getAppointment_time() != null)
            timeValue = appointment.getAppointment_time().toString();

        if (appointment.getReason() != null)
            reasonValue = appointment.getReason();

        if (appointment.getStatus() != null)
            statusValue = appointment.getStatus();
    }
%>

<div class="card">

    <div class="top-actions">
        <a href="<%=request.getContextPath()%>/appointments">Back</a>
        <a href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>

    <h2><%= isEdit ? "Edit Appointment" : "Book Appointment" %></h2>

    <form method="post"
          action="<%=request.getContextPath()%>/appointments">

        <input type="hidden"
               name="action"
               value="<%= isEdit ? "update" : "insert" %>">

        <% if (isEdit) { %>
            <input type="hidden"
                   name="appointment_id"
                   value="<%= appointment.getAppointment_id() %>">

            <input type="hidden"
                   name="patient_id"
                   value="<%= patientId %>">
        <% } %>

        <div class="form-group">
            <label>Doctor ID</label>
            <input type="number"
                   name="doctor_id"
                   value="<%= doctorId %>"
                   required>
        </div>

        <div class="form-group">
            <label>Appointment Date</label>
            <input type="date"
                   name="appointment_date"
                   value="<%= dateValue %>"
                   required>
        </div>

        <div class="form-group">
            <label>Appointment Time</label>
            <input type="time"
                   name="appointment_time"
                   value="<%= timeValue %>"
                   required>
        </div>

        <div class="form-group">
            <label>Reason</label>
            <textarea name="reason"><%= reasonValue %></textarea>
        </div>

        <% if (isEdit) { %>
        <div class="form-group">
            <label>Status</label>
            <select name="status">
                <option value="SCHEDULED"
                    <%= "SCHEDULED".equalsIgnoreCase(statusValue) ? "selected" : "" %>>
                    SCHEDULED
                </option>
                <option value="COMPLETED"
                    <%= "COMPLETED".equalsIgnoreCase(statusValue) ? "selected" : "" %>>
                    COMPLETED
                </option>
                <option value="CANCELLED"
                    <%= "CANCELLED".equalsIgnoreCase(statusValue) ? "selected" : "" %>>
                    CANCELLED
                </option>
            </select>
        </div>
        <% } %>

        <button type="submit">
            <%= isEdit ? "Update Appointment" : "Book Appointment" %>
        </button>

    </form>

</div>

</body>
</html>
