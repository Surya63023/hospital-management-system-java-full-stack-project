package com.hospital.filter;

import java.io.IOException;
import java.util.Set;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class RoleFilter extends HttpFilter implements Filter {

	private static final long serialVersionUID = 1L;

	private static final Set<String> ADMIN_ONLY = Set.of("/admin-dashboard", "/doctors", "/patients", "/departments");

	private static final Set<String> ADMIN_DOCTOR_PATIENT = Set.of("/appointments", "/prescriptions");

	private static final Set<String> DOCTOR_ONLY = Set.of("/doctor-appointments");

	private static final Set<String> ADMIN_DOCTOR_PATIENT_REPORT = Set.of("/reports");

	@Override
	protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String path = uri.substring(contextPath.length());

		if (path.equals("/login") || path.equals("/logout") || path.equals("/register") || path.startsWith("/css/")
				|| path.startsWith("/js/") || path.startsWith("/images/") || path.startsWith("/fonts/")) {

			chain.doFilter(request, response);
			return;
		}

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("role") == null) {
			response.sendRedirect(contextPath + "/login");
			return;
		}

		String role = session.getAttribute("role").toString();

		if (ADMIN_ONLY.contains(path)) {
			if (!"ADMIN".equalsIgnoreCase(role)) {
				response.sendRedirect(contextPath + "/login");
				return;
			}
		} else if (DOCTOR_ONLY.contains(path)) {
			if (!"DOCTOR".equalsIgnoreCase(role)) {
				response.sendRedirect(contextPath + "/login");
				return;
			}
		} else if (path.equals("/reports")) {
			if (!"ADMIN".equalsIgnoreCase(role) && !"DOCTOR".equalsIgnoreCase(role)
					&& !"PATIENT".equalsIgnoreCase(role)) {
				response.sendRedirect(contextPath + "/login");
				return;
			}
		} else if (ADMIN_DOCTOR_PATIENT.contains(path)) {
			if (!"ADMIN".equalsIgnoreCase(role) && !"DOCTOR".equalsIgnoreCase(role)
					&& !"PATIENT".equalsIgnoreCase(role)) {
				response.sendRedirect(contextPath + "/login");
				return;
			}
		}

		chain.doFilter(request, response);
	}
}
