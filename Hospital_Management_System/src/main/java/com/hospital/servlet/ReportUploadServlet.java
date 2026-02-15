package com.hospital.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.hospital.dao.MedicalReportsDAO;
import com.hospital.dao.PatientsDAO;
import com.hospital.dao.AppointmentsDAO;
import com.hospital.dao.DoctorsDAO;

import com.hospital.daoimpl.MedicalReportsDAOImpl;
import com.hospital.daoimpl.PatientsDAOImpl;
import com.hospital.daoimpl.AppointmentsDAOImpl;
import com.hospital.daoimpl.DoctorsDAOImpl;

import com.hospital.model.MedicalReports;
import com.hospital.model.Patients;
import com.hospital.model.Users;
import com.hospital.model.Appointments;
import com.hospital.model.Doctors;

@WebServlet("/reports")
@MultipartConfig
public class ReportUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private MedicalReportsDAO reportsDAO;
    private PatientsDAO patientsDAO;
    private AppointmentsDAO appointmentsDAO;
    private DoctorsDAO doctorsDAO;

    @Override
    public void init() {
        reportsDAO = new MedicalReportsDAOImpl();
        patientsDAO = new PatientsDAOImpl();
        appointmentsDAO = new AppointmentsDAOImpl();
        doctorsDAO = new DoctorsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = session.getAttribute("role").toString();
        String action = request.getParameter("action");

        try {

            // ===============================
            // UPLOAD PAGE (DOCTOR ONLY)
            // ===============================
            if ("upload".equals(action)) {

                if (!"DOCTOR".equalsIgnoreCase(role)) {
                    response.sendRedirect(request.getContextPath() + "/reports");
                    return;
                }

                request.getRequestDispatcher("/report-form.jsp")
                       .forward(request, response);
                return;
            }

            // ===============================
            // LIST REPORTS
            // ===============================
            if ("ADMIN".equalsIgnoreCase(role)) {

                List<MedicalReports> list = reportsDAO.findAll(0, 100);
                request.setAttribute("reportList", list);

            } else if ("PATIENT".equalsIgnoreCase(role)) {

                Users user = (Users) session.getAttribute("loggedUser");
                Patients patient = patientsDAO.findByUserId(user.getUser_id());

                if (patient != null) {
                    List<MedicalReports> list =
                            reportsDAO.findByPatientId(patient.getPatient_id());
                    request.setAttribute("reportList", list);
                }

            } else if ("DOCTOR".equalsIgnoreCase(role)) {

                Users user = (Users) session.getAttribute("loggedUser");
                Doctors doctor = doctorsDAO.findByUserId(user.getUser_id());

                if (doctor != null) {

                    List<Appointments> appointments =
                            appointmentsDAO.findByDoctorId(doctor.getDoctor_id());

                    List<MedicalReports> reportList = new ArrayList<>();

                    for (Appointments appointment : appointments) {
                        List<MedicalReports> patientReports =
                                reportsDAO.findByPatientId(appointment.getPatient_id());

                        reportList.addAll(patientReports);
                    }

                    request.setAttribute("reportList", reportList);
                }
            }

            request.getRequestDispatcher("/reports.jsp")
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

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = session.getAttribute("role").toString();
        String action = request.getParameter("action");

        if (!"upload".equals(action) || 
            !"DOCTOR".equalsIgnoreCase(role)) {

            response.sendRedirect(request.getContextPath() + "/reports");
            return;
        }

        try {

            String reportType = request.getParameter("report_type");
            String description = request.getParameter("report_description");
            String reportDateParam = request.getParameter("report_date");
            String appointmentIdParam = request.getParameter("appointment_id");

            if (appointmentIdParam == null) {
                response.sendRedirect(request.getContextPath() + "/doctor-appointments");
                return;
            }

            int appointmentId = Integer.parseInt(appointmentIdParam);

            Appointments appointment =
                    appointmentsDAO.findById(appointmentId);

            if (appointment == null ||
                !"COMPLETED".equalsIgnoreCase(appointment.getStatus())) {

                response.sendRedirect(request.getContextPath() + "/doctor-appointments");
                return;
            }

            Users user = (Users) session.getAttribute("loggedUser");
            Doctors doctor = doctorsDAO.findByUserId(user.getUser_id());

            if (!appointment.getDoctor_id()
                    .equals(doctor.getDoctor_id())) {

                response.sendRedirect(request.getContextPath() + "/doctor-appointments");
                return;
            }

            Integer patientId = appointment.getPatient_id();

            Part filePart = request.getPart("file");

            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect(request.getContextPath() + "/reports");
                return;
            }

            String fileName =
                    Paths.get(filePart.getSubmittedFileName())
                            .getFileName().toString();

            String uniqueFileName =
                    UUID.randomUUID() + "_" + fileName;

            String uploadPath =
                    getServletContext().getRealPath("") +
                            File.separator + "uploads";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + uniqueFileName);

            MedicalReports report = new MedicalReports();
            report.setPatient_id(patientId);
            report.setReport_type(reportType);
            report.setReport_description(description);
            report.setReport_date(LocalDate.parse(reportDateParam));
            report.setFile_path("uploads/" + uniqueFileName);

            reportsDAO.save(report);

            response.sendRedirect(request.getContextPath() + "/reports");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
