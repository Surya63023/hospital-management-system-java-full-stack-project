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
import com.hospital.dao.DepartmentsDAO;
import com.hospital.dao.DoctorsDAO;
import com.hospital.dao.MedicalReportsDAO;
import com.hospital.dao.PatientsDAO;
import com.hospital.dao.PrescriptionsDAO;
import com.hospital.dao.UsersDAO;
import com.hospital.daoimpl.AppointmentsDAOImpl;
import com.hospital.daoimpl.DepartmentsDAOImpl;
import com.hospital.daoimpl.DoctorsDAOImpl;
import com.hospital.daoimpl.MedicalReportsDAOImpl;
import com.hospital.daoimpl.PatientsDAOImpl;
import com.hospital.daoimpl.PrescriptionsDAOImpl;
import com.hospital.daoimpl.UsersDAOImpl;
import com.hospital.model.Appointments;
import com.hospital.model.Departments;
import com.hospital.model.Doctors;
import com.hospital.model.MedicalReports;
import com.hospital.model.Patients;
import com.hospital.model.Prescriptions;
import com.hospital.model.Users;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UsersDAO usersDAO;
    private DoctorsDAO doctorsDAO;
    private PatientsDAO patientsDAO;
    private DepartmentsDAO departmentsDAO;
    private AppointmentsDAO appointmentsDAO;
    private PrescriptionsDAO prescriptionsDAO;
    private MedicalReportsDAO reportsDAO;

    @Override
    public void init() {
        usersDAO = new UsersDAOImpl();
        doctorsDAO = new DoctorsDAOImpl();
        patientsDAO = new PatientsDAOImpl();
        departmentsDAO = new DepartmentsDAOImpl();
        appointmentsDAO = new AppointmentsDAOImpl();
        prescriptionsDAO = new PrescriptionsDAOImpl();
        reportsDAO = new MedicalReportsDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null ||
            !"ADMIN".equalsIgnoreCase(session.getAttribute("role").toString())) {

            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {

            int largeLimit = 10000;

            List<Users> users = usersDAO.findAll(0, largeLimit);
            List<Doctors> doctors = doctorsDAO.findAll(0, largeLimit);
            List<Patients> patients = patientsDAO.findAll(0, largeLimit);
            List<Departments> departments = departmentsDAO.findAll();
            List<Appointments> appointments = appointmentsDAO.findAll(0, largeLimit);
            List<Prescriptions> prescriptions = prescriptionsDAO.findAll(0, largeLimit);
            List<MedicalReports> reports = reportsDAO.findAll(0, largeLimit);

            request.setAttribute("totalUsers", users.size());
            request.setAttribute("totalDoctors", doctors.size());
            request.setAttribute("totalPatients", patients.size());
            request.setAttribute("totalDepartments", departments.size());
            request.setAttribute("totalAppointments", appointments.size());
            request.setAttribute("totalPrescriptions", prescriptions.size());
            request.setAttribute("totalReports", reports.size());

            List<Appointments> recentAppointments =
                    appointmentsDAO.findAll(0, 10);

            List<Prescriptions> recentPrescriptions =
                    prescriptionsDAO.findAll(0, 10);

            List<MedicalReports> recentReports =
                    reportsDAO.findAll(0, 10);

            request.setAttribute("recentAppointments", recentAppointments);
            request.setAttribute("recentPrescriptions", recentPrescriptions);
            request.setAttribute("recentReports", recentReports);

            request.getRequestDispatcher("admin-dashboard.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
