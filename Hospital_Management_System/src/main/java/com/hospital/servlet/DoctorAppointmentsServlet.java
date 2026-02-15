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
import com.hospital.dao.DoctorsDAO;
import com.hospital.daoimpl.AppointmentsDAOImpl;
import com.hospital.daoimpl.DoctorsDAOImpl;
import com.hospital.model.Appointments;
import com.hospital.model.Doctors;
import com.hospital.model.Users;

@WebServlet("/doctor-appointments")
public class DoctorAppointmentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentsDAO appointmentsDAO;
    private DoctorsDAO doctorsDAO;

    @Override
    public void init() {
        appointmentsDAO = new AppointmentsDAOImpl();
        doctorsDAO = new DoctorsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("role") == null ||
            !"DOCTOR".equalsIgnoreCase(
                session.getAttribute("role").toString())) {

            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users user = (Users) session.getAttribute("loggedUser");

        try {
            Doctors doctor =
                doctorsDAO.findByUserId(user.getUser_id());

            if (doctor == null) {
                response.sendRedirect(
                    request.getContextPath() + "/login");
                return;
            }

            // 🔥 FETCH ALL APPOINTMENTS (NO DATE FILTER)
            List<Appointments> appointments =
                appointmentsDAO.findByDoctorId(
                    doctor.getDoctor_id());

            request.setAttribute("appointmentList",
                                 appointments);

            request.getRequestDispatcher(
                "doctor-appointments.jsp")
                .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("role") == null ||
            !"DOCTOR".equalsIgnoreCase(
                session.getAttribute("role").toString())) {

            response.sendRedirect(request.getContextPath()
                                  + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("status".equals(action)) {

            String appointmentIdParam =
                request.getParameter("appointment_id");

            String status =
                request.getParameter("status");

            if (appointmentIdParam != null &&
                status != null &&
                ("COMPLETED".equalsIgnoreCase(status) ||
                 "CANCELLED".equalsIgnoreCase(status))) {

                try {
                    appointmentsDAO.updateStatus(
                        Integer.parseInt(appointmentIdParam),
                        status.toUpperCase()
                    );
                } catch (SQLException e) {
                    throw new ServletException(e);
                }
            }
        }

        response.sendRedirect(request.getContextPath()
                              + "/doctor-appointments");
    }
}
