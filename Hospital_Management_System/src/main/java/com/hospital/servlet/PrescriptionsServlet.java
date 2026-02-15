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
import com.hospital.dao.PrescriptionsDAO;
import com.hospital.daoimpl.AppointmentsDAOImpl;
import com.hospital.daoimpl.DoctorsDAOImpl;
import com.hospital.daoimpl.PrescriptionsDAOImpl;
import com.hospital.model.Appointments;
import com.hospital.model.Doctors;
import com.hospital.model.Prescriptions;
import com.hospital.model.Users;

@WebServlet("/prescriptions")
public class PrescriptionsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PrescriptionsDAO prescriptionsDAO;
    private AppointmentsDAO appointmentsDAO;
    private DoctorsDAO doctorsDAO;

    @Override
    public void init() {
        prescriptionsDAO = new PrescriptionsDAOImpl();
        appointmentsDAO = new AppointmentsDAOImpl();
        doctorsDAO = new DoctorsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = session.getAttribute("role").toString();
        String action = request.getParameter("action");

        try {

            if ("ADMIN".equalsIgnoreCase(role) && action == null) {

                int page = 1;
                int limit = 10;
                String pageParam = request.getParameter("page");

                if (pageParam != null) {
                    page = Integer.parseInt(pageParam);
                }

                int offset = (page - 1) * limit;

                List<Prescriptions> list = prescriptionsDAO.findAll(offset, limit);
                request.setAttribute("prescriptionList", list);
                request.setAttribute("currentPage", page);

                request.getRequestDispatcher("prescriptions.jsp").forward(request, response);
                return;
            }

            if ("view".equals(action)) {

                String appointmentIdParam = request.getParameter("appointment_id");
                if (appointmentIdParam == null) {
                    response.sendRedirect(request.getContextPath() + "/prescriptions");
                    return;
                }

                Integer appointmentId = Integer.parseInt(appointmentIdParam);
                Appointments appointment = appointmentsDAO.findById(appointmentId);

                if (appointment == null) {
                    response.sendRedirect(request.getContextPath() + "/prescriptions");
                    return;
                }

                if (!isAuthorized(role, session, appointment)) {
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }

                Prescriptions prescription =
                        prescriptionsDAO.findByAppointmentId(appointmentId);

                request.setAttribute("prescription", prescription);
                request.getRequestDispatcher("prescription-view.jsp")
                       .forward(request, response);
                return;
            }

            if ("edit".equals(action) && "DOCTOR".equalsIgnoreCase(role)) {

                String idParam = request.getParameter("id");
                if (idParam == null) {
                    response.sendRedirect(request.getContextPath() + "/prescriptions");
                    return;
                }

                Prescriptions prescription =
                        prescriptionsDAO.findById(Integer.parseInt(idParam));

                request.setAttribute("prescription", prescription);
                request.getRequestDispatcher("prescription-form.jsp")
                       .forward(request, response);
                return;
            }

            response.sendRedirect(request.getContextPath() + "/prescriptions");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = session.getAttribute("role").toString();
        String action = request.getParameter("action");

        try {

            if ("DOCTOR".equalsIgnoreCase(role) && "insert".equals(action)) {

                String appointmentIdParam = request.getParameter("appointment_id");
                String diagnosis = request.getParameter("diagnosis");
                String medicines = request.getParameter("medicines");
                String instructions = request.getParameter("instructions");

                if (appointmentIdParam == null) {
                    response.sendRedirect(request.getContextPath() + "/prescriptions");
                    return;
                }

                Integer appointmentId = Integer.parseInt(appointmentIdParam);
                Appointments appointment = appointmentsDAO.findById(appointmentId);

                if (appointment == null ||
                    !isDoctorOwner(session, appointment)) {

                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }

                Prescriptions prescription = new Prescriptions();
                prescription.setAppointment_id(appointmentId);
                prescription.setDiagnosis(diagnosis);
                prescription.setMedicines(medicines);
                prescription.setInstructions(instructions);

                prescriptionsDAO.save(prescription);

                response.sendRedirect(request.getContextPath() + "/doctor-appointments");
                return;
            }

            if ("DOCTOR".equalsIgnoreCase(role) && "update".equals(action)) {

                String idParam = request.getParameter("prescription_id");
                if (idParam == null) {
                    response.sendRedirect(request.getContextPath() + "/prescriptions");
                    return;
                }

                Prescriptions prescription =
                        prescriptionsDAO.findById(Integer.parseInt(idParam));

                if (prescription == null) {
                    response.sendRedirect(request.getContextPath() + "/prescriptions");
                    return;
                }

                Appointments appointment =
                        appointmentsDAO.findById(prescription.getAppointment_id());

                if (!isDoctorOwner(session, appointment)) {
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }

                prescription.setDiagnosis(request.getParameter("diagnosis"));
                prescription.setMedicines(request.getParameter("medicines"));
                prescription.setInstructions(request.getParameter("instructions"));

                prescriptionsDAO.update(prescription);

                response.sendRedirect(request.getContextPath() + "/doctor-appointments");
                return;
            }

            if ("ADMIN".equalsIgnoreCase(role) && "delete".equals(action)) {

                String idParam = request.getParameter("prescription_id");
                if (idParam != null) {
                    prescriptionsDAO.deleteById(Integer.parseInt(idParam));
                }

                response.sendRedirect(request.getContextPath() + "/prescriptions");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/prescriptions");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private boolean isAuthorized(String role, HttpSession session, Appointments appointment)
            throws SQLException {

        if ("ADMIN".equalsIgnoreCase(role)) {
            return true;
        }

        Users user = (Users) session.getAttribute("loggedUser");

        if ("PATIENT".equalsIgnoreCase(role)) {
            return appointment.getPatient_id().equals(user.getUser_id());
        }

        if ("DOCTOR".equalsIgnoreCase(role)) {
            Doctors doctor = doctorsDAO.findByUserId(user.getUser_id());
            return doctor != null &&
                   appointment.getDoctor_id().equals(doctor.getDoctor_id());
        }

        return false;
    }

    private boolean isDoctorOwner(HttpSession session, Appointments appointment)
            throws SQLException {

        Users user = (Users) session.getAttribute("loggedUser");
        Doctors doctor = doctorsDAO.findByUserId(user.getUser_id());

        return doctor != null &&
               appointment.getDoctor_id().equals(doctor.getDoctor_id());
    }
}
