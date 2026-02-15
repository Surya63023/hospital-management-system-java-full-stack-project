package com.hospital.servlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.hospital.dao.UsersDAO;
import com.hospital.daoimpl.UsersDAOImpl;
import com.hospital.model.Users;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UsersDAO usersDAO;

    @Override
    public void init() {
        usersDAO = new UsersDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {

            request.setAttribute("error", "All required fields must be filled.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            Users existingUser = usersDAO.findByEmail(email.trim());

            if (existingUser != null) {
                request.setAttribute("error", "Email already registered.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            Users user = new Users();
            user.setName(name.trim());
            user.setEmail(email.trim());
            user.setPassword(password);
            user.setPhone(phone.trim());
            user.setAddress(address);
            user.setRole("PATIENT");

            usersDAO.save(user);

            response.sendRedirect(request.getContextPath() + "/login");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
