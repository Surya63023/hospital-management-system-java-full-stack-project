package com.hospital.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.hospital.dao.AppointmentsDAO;
import com.hospital.daoimpl.AppointmentsDAOImpl;
import com.hospital.dao.PatientsDAO;
import com.hospital.daoimpl.PatientsDAOImpl;
import com.hospital.model.Appointments;
import com.hospital.model.Patients;
import com.hospital.model.Users;

@WebServlet("/patient-dashboard")
public class PatientDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PatientsDAO patientsDAO;
    private AppointmentsDAO appointmentsDAO;

    @Override
    public void init() {
        patientsDAO = new PatientsDAOImpl();
        appointmentsDAO = new AppointmentsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedUser") == null ||
            !"PATIENT".equalsIgnoreCase(
                session.getAttribute("role").toString())) {

            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users user = (Users) session.getAttribute("loggedUser");

        try {
            Patients patient =
                patientsDAO.findByUserId(user.getUser_id());

            List<Appointments> appointments =
                appointmentsDAO.findByPatientId(patient.getPatient_id());

            request.setAttribute("patient", patient);
            request.setAttribute("appointments", appointments);

            request.getRequestDispatcher("/patient-dashboard.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
