<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
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

        .error-card {
            background:white;
            padding:40px;
            border-radius:12px;
            box-shadow:0 10px 25px rgba(0,0,0,0.15);
            width:100%;
            max-width:500px;
            text-align:center;
        }

        h1 {
            color:#dc2626;
            margin-bottom:15px;
        }

        p {
            margin-bottom:10px;
            color:#374151;
            font-size:14px;
        }

        .status {
            font-weight:bold;
            color:#1f2937;
        }

        .btn-group {
            margin-top:20px;
        }

        a {
            text-decoration:none;
            padding:8px 14px;
            border-radius:6px;
            background:#2563eb;
            color:white;
            font-weight:bold;
            margin:5px;
            display:inline-block;
        }

        a:hover {
            background:#1d4ed8;
        }
    </style>
</head>
<body>

<%
    String customError = (String) request.getAttribute("error");
    String servletError = (String) request.getAttribute("jakarta.servlet.error.message");
    Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
    Throwable exception = (Throwable) request.getAttribute("jakarta.servlet.error.exception");

    String message = null;

    if (customError != null) {
        message = customError;
    } else if (servletError != null) {
        message = servletError;
    } else {
        message = "An unexpected error occurred.";
    }
%>

<div class="error-card">

    <h1>Something Went Wrong</h1>

    <% if (statusCode != null) { %>
        <p class="status">Status Code: <%= statusCode %></p>
    <% } %>

    <p><%= message %></p>

    <%-- Do NOT show stack trace in production. 
         Uncomment below for development only. --%>
    <%--
    if (exception != null) {
    %>
        <p><%= exception.getMessage() %></p>
    <%
    }
    --%>

    <div class="btn-group">
        <a href="<%=request.getContextPath()%>/login">Login</a>
        <a href="<%=request.getContextPath()%>/admin-dashboard">Dashboard</a>
    </div>

</div>

</body>
</html>
