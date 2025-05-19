package com.kosmarket.controllers;

import java.io.*;

import com.kosmarket.models.Guest;
import com.kosmarket.models.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "AuthenticationControllerServlet", urlPatterns = "/auth")
public class AuthenticationController extends HttpServlet {

    public void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String menu = request.getParameter("menu");
        if (request.getParameterMap().isEmpty() || menu == null) {
            request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
        } else if ("check".equals(menu)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            boolean isValidUser = false;

            try {
                Member member = new Member(email);

                isValidUser = member.login(password);

                if (isValidUser) {
                    // session for logged-in user
                    HttpSession session = request.getSession();
                    session.setAttribute("member", member);
                    session.setAttribute("isLoggedIn", true);

                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password");
                    request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
            }
        } else if ("register".equals(menu)) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm-password");

            try {
                // validate input
                if (firstName == null || firstName.trim().isEmpty() ||
                    lastName == null || lastName.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    confirmPassword == null || confirmPassword.trim().isEmpty()) {

                    request.setAttribute("errorMessage", "All fields are required");
                    request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                    return;
                }

                // check if passwords match
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("errorMessage", "Passwords do not match");
                    request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                    return;
                }

                // register using as a guest
                Guest guest = new Guest();
                Member newMember = guest.registerAccount(firstName, lastName, email, password);

                HttpSession session = request.getSession();
                session.setAttribute("member", newMember);
                session.setAttribute("isLoggedIn", true);
                if (newMember != null) {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
            }
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }

}
