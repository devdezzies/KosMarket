package com.kosmarket.controllers;

import com.kosmarket.models.Member;
import com.kosmarket.models.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PublicProfileController", urlPatterns = "/public-profile")
public class PublicProfileController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID is required");
            return;
        }

        try {
            // Ambil member berdasarkan id
            Member memberModel = new Member();
            Member member = memberModel.find(idParam); // id dalam bentuk String

            if (member == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Member not found");
                return;
            }

            // Ambil semua produk
            Product productModel = new Product();
            List<Product> allProducts = productModel.get();
            List<Product> userProducts = new ArrayList<>();

            if (allProducts != null) {
                for (Product p : allProducts) {
                    if (p.getMemberId() == member.getId()) {
                        userProducts.add(p);
                    }
                }
            }

            // Kirim ke JSP
            request.setAttribute("member", member);
            request.setAttribute("products", userProducts);
            request.getRequestDispatcher("/WEB-INF/views/publicprofil.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Something went wrong");
            e.printStackTrace(); // Debug log
        }
    }
}
