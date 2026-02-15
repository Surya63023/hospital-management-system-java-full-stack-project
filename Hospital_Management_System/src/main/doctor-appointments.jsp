<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hospital.model.Appointments"%>

<!DOCTYPE html>
<html>
<head>
<title>Doctor Appointments</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial;
}

body {
	background: #f4f6f9;
	padding: 20px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.header div a {
	margin-left: 10px;
}

h2 {
	color: #1f2937;
}

button {
	padding: 8px 14px;
	border: none;
	border-radius: 6px;
	background: #2563eb;
	color: white;
	cursor: pointer;
}

button:hover {
	background: #1d4ed8;
}

table {
	width: 100%;
	border-collapse: collapse;
	background: white;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #eee;
}

th {
	background: #1f2937;
	color: white;
}

tr:hover {
	background: #f1f5f9;
}
</style>
</head>
<body>

	<div class="header">
		<h2>Doctor Appointments</h2>

		<div>
			<a href="<%=request.getContextPath()%>/doctor-dashboard">
				<button>Dashboard</button>
			</a> <a href="<%=request.getContextPath()%>/logout">
				<button>Logout</button>
			</a>
		</div>
	</div>


	<br>

	<table>
		<tr>
			<th>ID</th>
			<th>Patient ID</th>
			<th>Date</th>
			<th>Time</th>
			<th>Reason</th>
			<th>Status</th>
			<th>Update</th>
			<th>Upload Report</th>
		</tr>

		<%
		List<Appointments> appointmentList = (List<Appointments>) request.getAttribute("appointmentList");

		if (appointmentList != null && !appointmentList.isEmpty()) {

			for (Appointments a : appointmentList) {
		%>
		<tr>
			<td><%=a.getAppointment_id()%></td>
			<td><%=a.getPatient_id()%></td>
			<td><%=a.getAppointment_date()%></td>
			<td><%=a.getAppointment_time()%></td>
			<td><%=a.getReason()%></td>
			<td><%=a.getStatus()%></td>

			<td>
				<%
				if ("SCHEDULED".equalsIgnoreCase(a.getStatus())) {
				%>
				<form method="post"
					action="<%=request.getContextPath()%>/doctor-appointments">
					<input type="hidden" name="action" value="status"> <input
						type="hidden" name="appointment_id"
						value="<%=a.getAppointment_id()%>"> <select name="status">
						<option value="COMPLETED">COMPLETED</option>
						<option value="CANCELLED">CANCELLED</option>
					</select>

					<button type="submit">Update</button>
				</form> <%
 } else {
 %> - <%
 }
 %>
			</td>

			<td>
				<%
				if ("COMPLETED".equalsIgnoreCase(a.getStatus())) {
				%> <a
				href="<%=request.getContextPath()%>/reports?action=upload&appointment_id=<%=a.getAppointment_id()%>">
					<button type="button">Upload</button>
			</a> <%
 } else {
 %> - <%
 }
 %>
			</td>
		</tr>
		<%
		}
		} else {
		%>
		<tr>
			<td colspan="8" style="text-align: center;">No appointments
				found.</td>
		</tr>
		<%
		}
		%>

	</table>

</body>
</html>
