package com.hospital.servlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.hospital.dao.UsersDAO;
import com.hospital.daoimpl.UsersDAOImpl;
import com.hospital.model.Users;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UsersDAO usersDAO;

    @Override
    public void init() {
        usersDAO = new UsersDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Email and Password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            Users user = usersDAO.findByEmail(email.trim());

            if (user == null) {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (!password.equals(user.getPassword())) {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("loggedUser", user);
            session.setAttribute("role", user.getRole());

            String role = user.getRole();

            if ("ADMIN".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard");
            } else if ("DOCTOR".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/doctor-dashboard");
            } else if ("PATIENT".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/patient-dashboard");
            } else {
                session.invalidate();
                request.setAttribute("error", "Unauthorized role.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
