<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hospital Management - Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, Helvetica, sans-serif;
}

body {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #1e3c72, #2a5298);
}

.register-container {
    width: 100%;
    max-width: 450px;
    background: #ffffff;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
    animation: fadeIn 0.7s ease-in-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #2a5298;
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
    transition: 0.3s;
}

input:focus, textarea:focus {
    border-color: #2a5298;
    outline: none;
    box-shadow: 0 0 5px rgba(42, 82, 152, 0.3);
}

textarea {
    resize: none;
    height: 60px;
}

.btn-register {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 6px;
    background-color: #2a5298;
    color: white;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

.btn-register:hover {
    background-color: #1e3c72;
}

.error-message {
    background-color: #ffe6e6;
    color: #b30000;
    padding: 10px;
    border-radius: 6px;
    margin-bottom: 15px;
    text-align: center;
    font-size: 14px;
}

.footer-link {
    margin-top: 15px;
    text-align: center;
}

.footer-link a {
    text-decoration: none;
    color: #2a5298;
    font-weight: bold;
}
</style>
</head>
<body>

<div class="register-container">

    <h2>Create Account</h2>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="error-message">
            <%= error %>
        </div>
    <%
        }
    %>

    <form method="post"
          action="<%= request.getContextPath() %>/register">

        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="name" required>
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" required>
        </div>

        <div class="form-group">
            <label>Address</label>
            <textarea name="address"></textarea>
        </div>

        <button type="submit" class="btn-register">
            Register
        </button>

    </form>

    <div class="footer-link">
        Already have an account?
        <a href="<%= request.getContextPath() %>/login">Login</a>
    </div>

</div>

</body>
</html>
