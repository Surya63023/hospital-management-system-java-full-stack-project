package com.hospital.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.hospital.dao.AppointmentsDAO;
import com.hospital.dao.DoctorsDAO;
import com.hospital.daoimpl.AppointmentsDAOImpl;
import com.hospital.daoimpl.DoctorsDAOImpl;
import com.hospital.model.Appointments;
import com.hospital.model.Doctors;
import com.hospital.model.Users;

@WebServlet("/doctor-dashboard")
public class DoctorDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DoctorsDAO doctorsDAO;
    private AppointmentsDAO appointmentsDAO;

    @Override
    public void init() {
        doctorsDAO = new DoctorsDAOImpl();
        appointmentsDAO = new AppointmentsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("role") == null ||
            !"DOCTOR".equalsIgnoreCase(session.getAttribute("role").toString())) {

            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users user = (Users) session.getAttribute("loggedUser");

        try {
            // STEP 1: Get doctor record using user_id
            Doctors doctor = doctorsDAO.findByUserId(user.getUser_id());

            if (doctor == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // STEP 2: Fetch appointments using doctor_id (NOT user_id)
            List<Appointments> list =
                    appointmentsDAO.findByDoctorId(doctor.getDoctor_id());

            request.setAttribute("doctor", doctor);
            request.setAttribute("appointments", list);
            request.setAttribute("totalAppointments", list.size());

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("doctor-dashboard.jsp")
               .forward(request, response);
    }
}
