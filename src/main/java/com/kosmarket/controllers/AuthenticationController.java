package com.kosmarket.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import com.kosmarket.models.Admin;
import com.kosmarket.models.Member;
import com.kosmarket.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AuthenticationControllerServlet", urlPatterns = "/authentication")
public class AuthenticationController extends HttpServlet {

    public void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String menu = request.getParameter("menu");

        if (menu == null) {
            request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
            return;
        }

        switch (menu) {
            case "check":
                handleLogin(request, response);
                break;
            case "register":
                handleRegister(request, response);
                break;
            case "logout":
                handleLogout(request, response);
                break;
            default:
                request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                break;
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/authentication");
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Admin adminModel = new Admin();
            Admin admin = adminModel.findByEmail(email);

            if (admin != null && password.equals(admin.getHashedPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                session.setAttribute("isLoggedIn", true);
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }

            Member memberModel = new Member();
            ArrayList<Member> users = memberModel.findByEmail(email);

            if (!users.isEmpty()) {
                Member user = users.get(0);
                if (PasswordUtil.checkPassword(password, user.getHashedPassword())) {
                    HttpSession session = request.getSession();
                    session.setAttribute("member", user);
                    session.setAttribute("isLoggedIn", true);
                    response.sendRedirect(request.getContextPath() + "/home");
                } else {
                    request.setAttribute("errorMessage", "Invalid email or password");
                    request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        try {
            // validate input
            if (firstName == null || firstName.trim().isEmpty() ||
                    lastName == null || lastName.trim().isEmpty() ||
                    username == null || username.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    confirmPassword == null || confirmPassword.trim().isEmpty()) {

                request.setAttribute("errorMessage", "All fields are required");
                request.setAttribute("tab", "register");
                request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                return;
            }

            // check if passwords match
            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Passwords do not match");
                request.setAttribute("tab", "register");
                request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                return;
            }

            Member existingMemberCheck = new Member();
            // check if username already exists
            if (!existingMemberCheck.findByUsername(username).isEmpty()) {
                request.setAttribute("errorMessage", "Username already exists. Please choose another one.");
                request.setAttribute("tab", "register");
                request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                return;
            }

            // check if email already exists
            if (!existingMemberCheck.findByEmail(email).isEmpty()) {
                request.setAttribute("errorMessage", "Email already exists. Please use another email or login.");
                request.setAttribute("tab", "register");
                request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
                return;
            }

            // register using Member model
            Member newMember = new Member();
            newMember.setFirstName(firstName);
            newMember.setLastName(lastName);
            newMember.setEmail(email);
            newMember.setUsername(username);
            newMember.setHashedPassword(PasswordUtil.hashPassword(password));
            newMember.setCreatedAt(new Date());

            newMember.insert();

            // fetch the newly created member to get all data (including ID)
            ArrayList<Member> users = newMember.findByEmail(email);


            if (!users.isEmpty()) {
                Member memberForSession = users.get(0);
                HttpSession session = request.getSession();
                session.setAttribute("member", memberForSession);
                session.setAttribute("isLoggedIn", true);
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                throw new Exception("Failed to retrieve user after registration.");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            request.setAttribute("tab", "register");
            request.getRequestDispatcher("/WEB-INF/views/authentication.jsp").forward(request, response);
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }
}
