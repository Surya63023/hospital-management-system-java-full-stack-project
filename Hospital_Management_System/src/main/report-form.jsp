<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
<head>
<title>Upload Medical Report</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f4f6f9;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.card {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 600px;
}

h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #1f2937;
}

.form-group {
    margin-bottom: 15px;
}

label {
    font-weight: bold;
    font-size: 14px;
}

input, textarea {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    border-radius: 6px;
    border: 1px solid #ccc;
}

textarea {
    resize: vertical;
    min-height: 80px;
}

button {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 6px;
    background: #2563eb;
    color: white;
    font-weight: bold;
    cursor: pointer;
    margin-top: 10px;
}

button:hover {
    background: #1d4ed8;
}

.top-actions {
    text-align: center;
    margin-bottom: 15px;
}

.top-actions a {
    text-decoration: none;
    color: #2563eb;
    font-weight: bold;
    margin-right: 15px;
}
</style>
</head>
<body>

<%
    String role = (String) session.getAttribute("role");
%>

<div class="card">

    <div class="top-actions">
        <a href="<%=request.getContextPath()%>/reports">Back to Reports</a>
        <a href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>

    <h2>Upload Medical Report</h2>

    <form method="post"
          action="<%=request.getContextPath()%>/reports"
          enctype="multipart/form-data">

        <input type="hidden" name="action" value="upload">

        <% if ("DOCTOR".equalsIgnoreCase(role)) { %>
            <input type="hidden" name="appointment_id"
                   value="<%=request.getParameter("appointment_id")%>">
        <% } %>

        <% if ("ADMIN".equalsIgnoreCase(role)) { %>
        <div class="form-group">
            <label>Patient ID</label>
            <input type="number" name="patient_id" required>
        </div>
        <% } %>

        <div class="form-group">
            <label>Report Type</label>
            <input type="text" name="report_type" required>
        </div>

        <div class="form-group">
            <label>Report Description</label>
            <textarea name="report_description"></textarea>
        </div>

        <div class="form-group">
            <label>Report Date</label>
            <input type="date" name="report_date" required>
        </div>

        <div class="form-group">
            <label>Select File</label>
            <input type="file" name="file" required>
        </div>

        <button type="submit">Upload Report</button>

    </form>

</div>

</body>
</html>
