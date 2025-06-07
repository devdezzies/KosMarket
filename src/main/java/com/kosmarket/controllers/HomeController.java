package com.kosmarket.controllers;

import com.kosmarket.models.Product;
import com.kosmarket.models.ProductCategory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "HomeControllerServlet", urlPatterns = "/home")
public class HomeController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Product productModel = new Product();

        // Filtering logic
        String[] categories = request.getParameterValues("category");
        String minPrice = request.getParameter("min-price");
        String maxPrice = request.getParameter("max-price");

        List<String> conditions = new ArrayList<>();

        if (categories != null && categories.length > 0) {
            conditions.add("categoryId IN (" + String.join(",", categories) + ")");
        }

        if (minPrice != null && !minPrice.isEmpty()) {
            conditions.add("price >= " + minPrice);
        }

        if (maxPrice != null && !maxPrice.isEmpty()) {
            conditions.add("price <= " + maxPrice);
        }

        if (!conditions.isEmpty()) {
            productModel.where(String.join(" AND ", conditions));
        }

        // Pass filter values back to the view to maintain state
        request.setAttribute("selectedCategories", categories != null ? java.util.Arrays.asList(categories) : new java.util.ArrayList<String>());
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);

        List<Product> products = productModel.get();
        request.setAttribute("products", products);

        ProductCategory categoryModel = new ProductCategory();
        List<ProductCategory> categoriesList = categoryModel.get();
        request.setAttribute("categories", categoriesList);

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
} 